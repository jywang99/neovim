local BASE_DIR_NAME = '.nvim'

local M = {}

function M.getPersistPath()
    local persistPath = vim.loop.cwd() .. '/' .. BASE_DIR_NAME
    return persistPath
end

local function pathExists(path)
    return io.open(path)~=nil
end

-- create .nvim directory on startup if doesn't exist
if not pathExists(M.getPersistPath()) then
    os.execute('mkdir ' .. M.getPersistPath())
end

return M
