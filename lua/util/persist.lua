local BASE_DIR_NAME = '.nvim'
local LAYOUT_FILE = 'workspace.vim'

local M = {}

function M.getPersistPath()
    local persistPath = vim.loop.cwd() .. '/' .. BASE_DIR_NAME
    return persistPath
end

local function pathExists(path)
    return io.open(path)~=nil
end

function M.getWorkspaceFile()
    local dataPath = M.getPersistPath()
    if not pathExists(dataPath) then
        return nil
    end
    dataPath = dataPath .. '/' .. LAYOUT_FILE
    if not pathExists(dataPath) then
        return nil
    end
    return dataPath
end

local function createNvimDir()
    local path = M.getPersistPath()
    os.execute('mkdir ' .. path)
    local file = io.open(path .. '/.gitignore', 'w')
    file:write(LAYOUT_FILE .. '\n', '\n')
    file:close()
end

-- create .nvim directory on startup if doesn't exist
if not pathExists(M.getPersistPath()) then
    createNvimDir()
end

return M

