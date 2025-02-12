local persist = require('util.persist')
local sidebar = require('util.sidebar')

local LAYOUT_FILE = 'workspace.vim'
local SHADA_FILE = 'shada'

-- create .nvim directory
vim.api.nvim_create_user_command('W',function()
    local new = persist.createNvimDir()
    if not new then
        print('Workspace directory already exists')
        return
    end

    -- gitignore
    local gitignore = persist.getPersistPath() .. '/.gitignore'
    local f = io.open(gitignore, 'w')
    if not f then
        print('Could not create .gitignore file')
        return
    end
    f:write(LAYOUT_FILE .. '\n' .. SHADA_FILE .. '\n')
    f:close()

    print('Workspace directory created')
end, {})

local M = {}

function M.saveWorkspace()
    -- if .nvim directory does not exist, do nothing
    if not persist.persistPathExists() then
        return
    end
    print('Saving workspace...')
    sidebar.nukePeripherals()
    vim.cmd(':wshada! ' .. persist.getPersistPath() .. '/' .. SHADA_FILE)
    vim.cmd(':mksession! ' .. persist.getPersistPath() .. '/' .. LAYOUT_FILE)
end

function M.loadWorkspace()
    local shadaPath = persist.getPersistedFile(SHADA_FILE)
    if shadaPath then
        vim.opt.shadafile = shadaPath
    end

    local sessionPath = persist.getPersistedFile(LAYOUT_FILE)
    if sessionPath then
        vim.cmd('source ' .. sessionPath)
    end
end

return M

