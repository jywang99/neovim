local BASE_DIR_NAME = '.nvim'
local LAYOUT_FILE = 'workspace.vim'

local M = {}

function M.getPersistPath()
    local persistPath = vim.loop.cwd() .. '/' .. BASE_DIR_NAME
    return persistPath
end

function M.pathExists(path)
    return io.open(path)~=nil
end

function M.getWorkspaceFile()
    local dataPath = M.getPersistPath()
    if not M.pathExists(dataPath) then
        return nil
    end
    dataPath = dataPath .. '/' .. LAYOUT_FILE
    if not M.pathExists(dataPath) then
        return nil
    end
    return dataPath
end

function M.persistPathExists()
    return M.pathExists(M.getPersistPath())
end

function M.createNvimDir()
    if M.persistPathExists() then
        return
    end
    local path = M.getPersistPath()
    os.execute('mkdir ' .. path)
    local file = io.open(path .. '/.gitignore', 'w')
    if file == nil then
        return
    end
    file:write(LAYOUT_FILE .. '\n', '\n')
    file:close()
end

return M

