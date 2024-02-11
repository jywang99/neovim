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

require("oil").setup({
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.select_tab",
        ["<C-i>"] = "actions.preview",
        ["<C-q>"] = "actions.close",
        ["<R>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["="] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
