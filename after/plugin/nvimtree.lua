-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local tree = require("nvim-tree")

tree.setup({
    view = {
        width = 30,
        preserve_window_proportions = true,
        number = true,
        relativenumber = true,

    },
    update_focused_file = {
        enable = true,
    },
})

