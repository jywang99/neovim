local dapui = require('dapui')

local M = {}

function M.closeLeftBufs()
    dapui.close()
    vim.cmd [[NvimTreeClose]]
end

function M.closeRightBufs()
    pcall(vim.cmd, 'UndotreeHide')
    pcall(vim.cmd, 'SymbolsOutlineClose')
end

function M.closeBottomBufs()
end

function M.nukePeripherals()
    M.closeLeftBufs()
    M.closeRightBufs()
    M.closeBottomBufs()
end

function M.nukeAndRun(func)
    M.nukePeripherals()
    func()
end

return M

