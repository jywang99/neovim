local dap = require('dap')
local dapui = require('dapui')
local bufUtils = require('util.buffers')
local sidebar = require('util.sidebar')
local vscode = require('dap.ext.vscode')
local whichkey = require('which-key')

dapui.setup()

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🔵', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text = '◯', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '⚪️', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '🟡', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

dapui.setup({
    layouts = {{
        elements = {
            { id = "repl", size = 0.15 },
            { id = "console", size = 0.85 }
        },
        position = "bottom",
        size = 10
    }, {
        elements = { { id = "scopes", size = 0.4 },
        { id = "breakpoints", size = 0.2 },
        { id = "stacks", size = 0.2 },
        { id = "watches", size = 0.2 }
    },
        position = "left",
        size = 40
    },
}})
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
    print('Variable interpolation with {foo} is supported')
    local exp = vim.fn.input("Log message: ")
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
vscode.load_launchjs('.nvim/launch.json', {})

local function toggleDapUi()
    if bufUtils.getFiletypeWindow('dapui_watches') > 0 then
        dapui.close()
        return
    end
    dapui.open()
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>d',
}
local mappings = {
    name = "Debug",
    i = { toggleDapUi, 'Toggle Dap UI' },
    -- breakpoint
    b = { [[:DapToggleBreakpoint<CR>]], "Toggle breakpoint" },
    c = { SetConditionalBreakpoint, "Set conditional breakpoint" },
    L = { SetLoggingBreakpoint, "Set logging breakpoint" },
    H = { SetHitCountBreakpoint, "Set hit count breakpoint" },
    -- debugging controls
    J = { [[:DapLoadLaunchJSON<CR>]], "Load launch json" },
    ["<Space>"] = { [[:DapContinue<CR>]], "Resume" },
    t = { [[:DapTerminate<CR>]], "Terminate" },
    l = { [[:DapStepInto<CR>]], "Step into" },
    h = { [[:DapStepOut<CR>]], "Step out" },
    j = { [[:DapStepOver<CR>]], "Step over" },
    r = { [[:DapRestartFrame<CR>]], "Restart frame" },
}
whichkey.register(mappings, opts)

