local tree = require("nvim-tree")
local sidebar = require('util.sidebar')
local whichkey = require('which-key')
local buffers = require('util.buffers')

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

local function toggleNvimTree()
    if buffers.getFiletypeBuffer('NvimTree') > 0 then
        vim.cmd [[NvimTreeClose]]
        return
    end
    sidebar.closeLeftBufs()
    buffers.doAndSwitchBackWindow(function()
        vim.cmd [[NvimTreeFocus]]
    end)
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    e = { toggleNvimTree, "Toggle NvimTree" },
    E = { function()
        sidebar.closeLeftBufs()
        vim.cmd [[NvimTreeFindFile]]
    end, "go to file in NvimTree" },
}
whichkey.register(mappings, opts)

