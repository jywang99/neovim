local whichkey = require('which-key')

vim.g.undotree_CustomUndotreeCmd = 'vertical 32 new'
vim.g.undotree_CustomDiffpanelCmd= 'belowright 12 new'

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    u = { [[:UndotreeToggle<CR>]], "Toggle Undotree" },
}
whichkey.register(mappings, opts)

