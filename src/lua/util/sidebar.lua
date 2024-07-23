local M = {}

function M.closeLeftBufs()
    require('dapui').close()
end

function M.closeRightBufs()
    pcall(vim.cmd, 'UndotreeHide')
    pcall(vim.cmd, 'SymbolsOutlineClose')
end

function M.closeBottomBufs()
    require('dapui').close()
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

