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
            quit_on_focus_loss = true,
            open_win_config = {
                relative = "editor",
                width = 50,
                height = 70,
            },
        },
    },
    update_focused_file = {
        enable = true,
    },
    filters = {
        git_ignored = false
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
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
