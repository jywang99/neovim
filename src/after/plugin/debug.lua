local dap = require('dap')
local dapui = require('dapui')
local sidebar = require('util.sidebar')
local vscode = require('dap.ext.vscode')
local persist = require('util.persist')

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🔵', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text = '◯', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '⚪️', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '🟡', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

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

function SetConditionalBreakpoint()
    local deleted_line = vim.fn.getline(vim.fn.line('.'))
    vim.cmd('normal! dd')
    dap.set_breakpoint(deleted_line)
end

function SetLoggingBreakpoint()
    local exp = vim.fn.input("Log message (interpolation with {foo}): ")
    dap.set_breakpoint(nil, nil, exp)
end

function SetHitCountBreakpoint()
    local times = vim.fn.input("Times: ")
    local numTimes = tonumber(times)
    if not numTimes then
        print('Invalid argument, number expected!')
        return
    end
    dap.set_breakpoint(nil, nil, times)
end

-- launch.json
local LAUNCH_JSON = persist.getPersistPath() .. '/launch.json'
local function readConfigAndDebug()
    if vim.fn.filereadable(LAUNCH_JSON) == 0 then
        print('No launch.json found')
        return
    end
    vscode.load_launchjs(LAUNCH_JSON, {})
    dap.continue()
end

-- set wrap for console so that line width adapts when enlarging it
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dapui_console' },
    desc = 'Line wrap for console',
    callback = function()
        vim.opt.linebreak = true
        vim.opt.wrap = true
        vim.opt.number = true
    end,
})

-- keybindings
local map = vim.keymap.set
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

