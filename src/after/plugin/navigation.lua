local map = vim.keymap.set

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
        -- ["`"] = "actions.cd",
        -- ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        -- ["g\\"] = "actions.toggle_trash",
        ['<leader>yp'] = {
            desc = 'Copy filepath to system clipboard',
            callback = function ()
                require('oil.actions').copy_entry_path.callback()
                vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
            end,
        },
    },
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },
})

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

