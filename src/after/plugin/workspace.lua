local persist = require('util.persist')
local sidebar = require('util.sidebar')
local whichkey = require('which-key')

local function saveSession()
    -- if workspace file does not exist, confirm saving
    if not persist.getWorkspaceFile() then
        local confirm = vim.fn.confirm('Save workspace?', '&Yes\n&No')
        if confirm ~= 1 then
            return
        end
    end
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

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    name = "LSP",
    -- editing
    q = { '<cmd>qa<cr>', "Quit Neovim" },
}
whichkey.register(mappings, opts)

