local persist = require('util.persist')
local sidebar = require('util.sidebar')

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

local function setKeymaps()
    local map = vim.keymap.set
    local dapui = require('dapui')

    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '🔵', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '◯', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text = '⚪️', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '🟡', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

    -- keybindings
    map("n", "<leader>di", dapui.toggle, { desc = "Toggle Dap UI" })
    map("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
    map("n", "<leader>dc", SetConditionalBreakpoint, { desc = "Set conditional breakpoint" })
    map("n", "<leader>dL", SetLoggingBreakpoint, { desc = "Set logging breakpoint" })
    map("n", "<leader>dH", SetHitCountBreakpoint, { desc = "Set hit count breakpoint" })
    map("n", "<leader>dj", ":DapLoadLaunchJSON<CR>", { desc = "Load launch json" })
    map("n", "<leader>ds", ":DapTerminate<CR>", { desc = "Terminate" })
    map("n", "<leader>dr", ":DapRestartFrame<CR>", { desc = "Restart frame" })

    -- debugging
    map("n", "<M-d>", readConfigAndDebug, { desc = "Read launch.json and debug" })
    map("n", "<M-r>", ":DapContinue<CR>", { desc = "Debug continue" })
    map("n", "<M-n>", ":DapStepOver<CR>", { desc = "Debug step over" })
    map("n", "<M-i>", ":DapStepInto<CR>", { desc = "Debug step into" })
    map("n", "<M-o>", ":DapStepOut<CR>", { desc = "Debug step out" })
    map("n", "<M-p>", dapui.eval, { desc = "Float element" })
end

-- breakpoint actions
function SetConditionalBreakpoint()
    local deleted_line = vim.fn.getline(vim.fn.line('.'))
    vim.cmd('normal! dd')
    require('dap').set_breakpoint(deleted_line)
end

function SetLoggingBreakpoint()
    local exp = vim.fn.input("Log message (interpolation with {foo}): ")
    require('dap').set_breakpoint(nil, nil, exp)
end

function SetHitCountBreakpoint()
    local times = vim.fn.input("Times: ")
    local numTimes = tonumber(times)
    if not numTimes then
        print('Invalid argument, number expected!')
        return
    end
    require('dap').set_breakpoint(nil, nil, times)
end

return {
    {
        'mfussenegger/nvim-dap',
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
        end
    },
    { 'theHamsta/nvim-dap-virtual-text', lazy = true },
    {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap' },
        config = function()
            require('telescope').load_extension('dap')
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio', 'theHamsta/nvim-dap-virtual-text' },
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
			{ id = "scopes", size = 0.4 },
			{ id = "breakpoints", size = 0.3 },
			{ id = "stacks", size = 0.3 },
		    },
		    position = "left",
		    size = 40
		}}
	    })
	    dap.listeners.after.event_initialized['dapui_config'] = function()
		sidebar.nukeAndRun(dapui.open)
	    end
	    dap.listeners.before.event_terminated['dapui_config'] = function()
		-- dapui.close()
	    end
	    dap.listeners.before.event_exited['dapui_config'] = function()
		-- dapui.close()
	    end
	    setKeymaps()
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

