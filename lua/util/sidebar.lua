local M = {}

function M.closeLeftBufs()
end

function M.closeRightBufs()
    pcall(vim.cmd, 'UndotreeHide')
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

