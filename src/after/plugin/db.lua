local whichkey = require('which-key')

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dbout' },
    desc = 'Keybindings for dbout',
    callback = function()
        local opts = {}
        vim.keymap.set('n', 'gd', '<Plug>(DBUI_JumpToForeignKey)', opts)
    end,
})

local function toggleDBUI()
    vim.cmd [[tabnew]]
    vim.cmd [[DBUI]]
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    D = { toggleDBUI, "Open DBUI" },
}
whichkey.register(mappings, opts)

-- auto-completion for sql
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'sql', 'mysql', 'plsql' },
    desc = 'Auto-completion for SQL',
    callback = function()
        require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
    end,
})
-- don't fold query results
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dbout' },
    desc = 'No fold for query results',
    callback = function()
        vim.cmd [[:set nofoldenable]]
    end,
})

