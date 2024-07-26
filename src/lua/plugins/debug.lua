local persist = require('util.persist')
local sidebar = require('util.sidebar')
local buffers = require('util.buffers')
local files = require('util.files')
local map = vim.keymap.set

local debuggables = { 'java', 'py', 'go', }
local replers = { 'py', 'go', }

-- launch.json
local LAUNCH_JSON = persist.getPersistPath() .. '/launch.json'
local function readConfigAndDebug()
    local vscode = require('dap.ext.vscode')
    local dap = require('dap')

    if vim.fn.filereadable(LAUNCH_JSON) == 0 then
        print('No launch.json found')
        return
    end
    vscode.load_launchjs(LAUNCH_JSON, {})
    dap.continue()
end

-- breakpoint actions
local function setConditionalBreakpoint()
    local deleted_line = vim.fn.getline(vim.fn.line('.'))
    vim.cmd('normal! dd')
    require('dap').set_breakpoint(deleted_line)
end

local function setLoggingBreakpoint()
    local exp = vim.fn.input("Log message (interpolation with {foo}): ")
    require('dap').set_breakpoint(nil, nil, exp)
end

local function setHitCountBreakpoint()
    local times = vim.fn.input("Times: ")
    local numTimes = tonumber(times)
    if not numTimes then
        print('Invalid argument, number expected!')
        return
    end
    require('dap').set_breakpoint(nil, nil, times)
end

local BP_FILE = persist.getPersistPath() .. '/breakpoints.json'

local function saveBreakpoints()
    local breakpoints_by_buf = require("dap.breakpoints").get()
    local any = false
    for _, buf_bps in pairs(breakpoints_by_buf) do
        if #buf_bps > 0 then
            any = true
            break
        end
    end

    -- if no breakpoints and file exists, truncate it
    if not any and vim.fn.filereadable(BP_FILE) == 1 then
        files.truncateFile(BP_FILE)
        return
    end

    -- file path -> breakpoints
    local breakpoints_by_file = {}
    for buf, buf_bps in pairs(breakpoints_by_buf) do
        breakpoints_by_file[vim.api.nvim_buf_get_name(buf)] = buf_bps
    end

    -- if doesn't exist create it:
    if vim.fn.filereadable(BP_FILE) == 0 then
        os.execute("touch " .. BP_FILE)
    end

    -- write breakpoints as json
    local fp = io.open(BP_FILE, "w")
    if fp == nil then
        print "Error opening file"
        return
    end
    local final = vim.fn.json_encode(breakpoints_by_file)
    fp:write(final)
end

local function loadBreakpoints()
    local fp = io.open(BP_FILE, "r")
    if fp == nil then
        return
    end

    local content = fp:read "*a"
    if content == "" then
        return
    end

    local bps = vim.fn.json_decode(content)
    local loaded_buffers = {}
    local found = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local file_name = vim.api.nvim_buf_get_name(buf)
        if bps[file_name] ~= nil and bps[file_name] ~= {} then
            found = true
        end
        loaded_buffers[file_name] = buf
    end
    if found == false then
        return
    end
    for path, buf_bps in pairs(bps) do
        for _, bp in pairs(buf_bps) do
            local line = bp.line
            local opts = {
                condition = bp.condition,
                log_message = bp.logMessage,
                hit_condition = bp.hitCondition,
            }
            require("dap.breakpoints").set(opts, tonumber(loaded_buffers[path]), line)
        end
    end
end

return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        config = function()
            local dap = require('dap')
            dap.adapters.coreclr = {
                type = 'executable',
                command = '/usr/lib/netcoredbg/netcoredbg',
                args = { '--interpreter=vscode' }
            }
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            }
            dap.adapters.python = {
                type = 'executable',
                command = 'python3',
                args = {'-m', 'debugpy.adapter'}
            }
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function() return '/usr/bin/python3' end,
                },
            }

            -- breakpoints
            map("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
            map("n", "<leader>dc", setConditionalBreakpoint, { desc = "Set conditional breakpoint" })
            map("n", "<leader>dl", setLoggingBreakpoint, { desc = "Set logging breakpoint" })
            map("n", "<leader>dh", setHitCountBreakpoint, { desc = "Set hit count breakpoint" })
            map("n", "<leader>dC", dap.clear_breakpoints, { desc = "Clear all breakpoints" })

            -- debugging controls
            map("n", "<leader>dj", ":DapLoadLaunchJSON<CR>", { desc = "Load launch json" })
            map("n", "<M-d>", readConfigAndDebug, { desc = "Load launch.json and debug" })
            map("n", "<M-r>", ":DapContinue<CR>", { desc = "Debug continue" })
            map("n", "<M-n>", ":DapStepOver<CR>", { desc = "Debug step over" })
            map("n", "<M-i>", ":DapStepInto<CR>", { desc = "Debug step into" })
            map("n", "<M-o>", ":DapStepOut<CR>", { desc = "Debug step out" })
            map("n", "<leader>ds", ":DapTerminate<CR>", { desc = "Terminate" })
            map("n", "<leader>dr", ":DapRestartFrame<CR>", { desc = "Restart frame" })
        end
    },
    { 'theHamsta/nvim-dap-virtual-text', lazy = true },
    {
        'nvim-telescope/telescope-dap.nvim',
        lazy = true,
        ft = debuggables,
        dependencies = { 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap' },
        config = function()
            require('telescope').load_extension('dap')
            local ts = require('telescope').extensions.dap

            map("n", "<leader>dp", ts.list_breakpoints, { desc = "List breakpoints" })
            map("n", "<leader>dv", ts.variables, { desc = "List variables" })
            map("n", "<leader>df", ts.frames, { desc = "List frames" })
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio', 'theHamsta/nvim-dap-virtual-text' },
        lazy = true,
        ft = debuggables,
        config = function()
            local dapui = require('dapui')
            local dap = require('dap')
            require("nvim-dap-virtual-text").setup()

            dapui.setup({
                layouts = {{
                    elements = {
                        { id = "repl", size = 0.5 },
                        { id = "console", size = 0.5 }
                    },
                    position = "bottom",
                    size = 10
                }, {
                    elements = {
                        { id = "scopes", size = 1 },
                    },
                    position = "left",
                    size = 40
                }}
            })

            -- https://microsoft.github.io/debug-adapter-protocol/specification#Events
            dap.listeners.after.event_initialized['dapui_config'] = function()
                print('Debug session started')

                -- find log buffer
                local filetype = vim.bo.filetype
                local target = 'dapui_console'
                if vim.tbl_contains(replers, filetype) then
                    target = 'dap-repl'
                else

                end
                local buf = buffers.getFiletypeBuffer(target)
                if not buf then
                    print('Dap console buffer not found')
                    return
                end

                -- open it in new tab
                buffers.openBufInNewTab(buf)
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
                print('Debug session terminated')
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
                print('Debug session exited')
            end
            dap.listeners.before.event_stopped['dapui_config'] = function()
                sidebar.nukeAndRun(dapui.open)
            end

            -- breakpoints
            vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '🔵', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '◯', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
            vim.fn.sign_define('DapLogPoint', { text = '⚪️', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
            vim.fn.sign_define('DapStopped', { text = '🟡', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

            -- keymaps
            map({"n", "v"}, "<M-p>", dapui.eval, { desc = "Evaluate expression" })
            map("n", "<leader>di", dapui.toggle, { desc = "Toggle Dap UI" })
            map("n", "<leader>dS", saveBreakpoints, { desc = "Save breakpoints to file" })

            -- persist breakpoints
            loadBreakpoints()
            vim.api.nvim_create_autocmd('VimLeavePre', {
                desc = 'Save breakpoints',
                callback = saveBreakpoints,
            })
        end,
    },
    {
        'mfussenegger/nvim-dap-python',
        lazy = true,
        ft = { 'py' },
        dependencies = { 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui' },
        config = function()
            require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        end
    },
    {
        'leoluz/nvim-dap-go',
        lazy = true,
        ft = { 'go' },
        dependencies = { 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui' },
        config = function()
            -- go
            require('dap-go').setup {
                dap_configurations = {
                    {
                        -- Must be "go" or it will be ignored by the plugin
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                -- delve configurations
                delve = {
                    args = {},
                    -- the build flags that are passed to delve.
                    -- defaults to empty string, but can be used to provide flags
                    -- such as "-tags=unit" to make sure the test suite is
                    -- compiled during debugging, for example.
                    -- passing build flags using args is ineffective, as those are
                    -- ignored by delve in dap mode.
                    build_flags = "",
                },
            }
        end
    },
}

