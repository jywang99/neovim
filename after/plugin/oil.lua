require("oil").setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.select_tab",
        ["<C-i>"] = "actions.preview",
        ["<C-q>"] = "actions.close",
        ["<R>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },
    use_default_keymaps = false,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
