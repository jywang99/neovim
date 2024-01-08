-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local tree = require("nvim-tree")
local view = require('nvim-tree.view')

tree.setup({
    view = {
        width = 40,
        preserve_window_proportions = true,
        number = true,
        relativenumber = true,

    },
    update_focused_file = {
        enable = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
        }
    }
})

