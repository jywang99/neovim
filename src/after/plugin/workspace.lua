local persist = require('util.persist')
local sidebar = require('util.sidebar')

local function saveSession()
    -- if workspace file does not exist, confirm saving
    if not persist.persistPathExists() then
        return
    end
    print('Saving workspace...')
    sidebar.nukePeripherals()
    vim.cmd(':mksession! ' .. persist.getPersistPath() .. '/workspace.vim')
end

vim.api.nvim_create_autocmd('VimLeavePre', {
    desc = 'Save workspace',
    callback = saveSession,
})

-- create .nvim directory
vim.api.nvim_create_user_command('W',function()
    local new = persist.createNvimDir()
    if not new then
        print('Workspace directory already exists')
        return
    end
    print('Workspace directory created')
end, {})

local function loadWorkspace()
    -- print('Loading workspace...')
    local path = persist.getWorkspaceFile()
    if path == nil then
        -- print('Workspace file not found')
        return
    end
    vim.cmd(':source ' .. path)
end

loadWorkspace()

