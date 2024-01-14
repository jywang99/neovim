local tree = require("nvim-tree")
local sidebar = require('util.sidebar')
local whichkey = require('which-key')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
    filters = {
        git_ignored = false
    }
})

local function go_to_previous_window()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>p", true, true, true), "n", true)
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>e',
}
local mappings = {
    name = "Explorer",
    e = { function()
        sidebar.closeLeftBufs()
        vim.cmd [[NvimTreeFocus]]
        go_to_previous_window()
    end, "Focus tree" },
    f = { function()
        sidebar.closeLeftBufs()
        vim.cmd [[NvimTreeFindFile]]
    end, "Show file in tree" },
}
whichkey.register(mappings, opts)

