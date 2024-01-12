local persist = require('util.persist')
local sidebar = require('util.sidebar')

local function saveSession()
    print('Saving workspace...')
    sidebar.nukePeripherals()
    vim.cmd(':mksession! ' .. persist.getPersistPath() .. '/workspace.vim')
end

vim.api.nvim_create_autocmd('VimLeavePre', {
    desc = 'Save workspace',
    callback = saveSession,
})

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

