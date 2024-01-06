-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local tree = require("nvim-tree")
local view = require('nvim-tree.view')

tree.setup({
    view = {
        width = 30,
    }
})

local function focus_file()
    if not view.is_visible() then
        return
    end
    vim.api.nvim_command(':NvimTreeFindFile')
    vim.api.nvim_command(':wincmd p')
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'*'},
  desc = 'Focus file in tree',
  callback = focus_file,
})

