local tree = require("nvim-tree")
local whichkey = require('which-key')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

tree.setup({
    view = {
        number = true,
        relativenumber = true,
        float = {
            enable = true,
        },
    },
    update_focused_file = {
        enable = true,
    },
    filters = {
        git_ignored = false
    }
})

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    e = { function() vim.cmd [[NvimTreeFindFile]] end, "Toggle NvimTree" },
}
whichkey.register(mappings, opts)

