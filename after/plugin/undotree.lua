local bufUtils = require('util.buffers')
local sidebar = require('util.sidebar')
local whichkey = require('which-key')

vim.g.undotree_WindowLayout = 3

local function toggleUndoTree()
    if bufUtils.getFiletypeBuffer('undotree') > 0 then
        vim.cmd [[UndotreeHide]]
        return
    end
    sidebar.closeRightBufs()
    vim.cmd [[UndotreeShow]]
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    u = { toggleUndoTree, "Toggle Undotree" },
}
whichkey.register(mappings, opts)

