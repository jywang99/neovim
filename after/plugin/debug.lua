local dapui = require('dapui')
local dap = require('dap')

dapui.setup()

vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='⭕️', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='○', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='⚪️', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='🟢', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

function SetConditionalBreakpoint()
    local exp = vim.fn.input("Expression: ")
    dap.set_breakpoint(exp)
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

