local files = require('util.files')

local BASE_DIR_NAME = '.nvim'

local M = {}

function M.getPersistPath()
    local persistPath = vim.loop.cwd() .. '/' .. BASE_DIR_NAME
    return persistPath
end

function M.getPersistedFile(file)
    local dataPath = M.getPersistPath()
    if not files.pathExists(dataPath) then
        return nil
    end
    local layoutPath = dataPath .. '/' .. file
    if not files.pathExists(layoutPath) then
        return nil
    end
    return layoutPath
end

function M.persistPathExists()
    return files.pathExists(M.getPersistPath())
end

function M.createNvimDir()
    if M.persistPathExists() then
        return false
    end
    os.execute('mkdir ' .. M.getPersistPath())
    return true
end

return M

