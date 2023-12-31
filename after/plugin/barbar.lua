require'barbar'.setup {
  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    NvimTree = {text = 'undotree'},
    undotree = {text = 'undotree'},
    Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
  },
}

-- Keymap
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', 'g,', '<Cmd>BufferPrevious<CR>', opts)
map('n', 'g.', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<leader>b<', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<leader>b>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<leader>b1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>b2', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<leader>b3', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<leader>b4', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<leader>b5', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<leader>b6', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<leader>b7', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<leader>b8', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<leader>b9', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<leader>b0', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<leader>bp', '<Cmd>BufferPin<CR>', opts)
-- Wipeout buffer

-- Close commands
map('n', 'gw', '<Cmd>BufferClose<CR>', opts)
map('n', '<leader>bka', '<Cmd>BufferWipeout<CR>', opts)
map('n', '<leader>bko', '<Cmd>BufferCloseAllButCurrent<CR>', opts)
map('n', '<leader>bkh', '<Cmd>BufferCloseBuffersLeft<CR>', opts)
map('n', '<leader>bkl', '<Cmd>BufferCloseBuffersRight<CR>', opts)
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned

-- Magic buffer-picking mode
map('n', '<leader>bp', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<leader>bob', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<leader>bod', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<leader>bol', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<leader>bow', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

