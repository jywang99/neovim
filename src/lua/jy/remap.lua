local r = require('util.registers')
local map = vim.keymap.set
local bmap = vim.api.nvim_buf_set_keymap

vim.g.mapleader = " "

-- navigation
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- clipboard
map("v", "<C-c>", [["+y]])
map("x", "<leader>p", [["_dP]]) -- greatest remap ever

-- options
map("n", "<leader>n", ":noh<CR>", { desc = "Clear highlights" })
map("n", "<leader>oh", ":set invhlsearch<CR>", { desc = "Toggle search highlights" })
map("n", "<leader>op", ":set invpaste<CR>", { desc = "Toggle paste mode" })
map("n", "<leader>on", ":set invnumber<CR>", { desc = "Toggle line number" })
map("n", "<leader>or", ":set invrelativenumber<CR>", { desc = "Toggle relative number" })

map("n", "<leader>rs", r.promptAndSwap, { desc = "Swap registers" })

-- text manipulation
map("v", "J", ":m '>+1<CR>gv=gv") -- move line
map("v", "K", ":m '<-2<CR>gv=gv")
map('i', '<C-c>', '<Esc>O') -- newline above

map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })

-- quickfix
map("n", "<M-c>", "<CMD>cnext<CR>zz", { desc = "Forward quickfix" })
map("n", "<M-q>", "<CMD>cprev<CR>zz", { desc = "Backward quickfix" })
map("n", "<leader>co", "<CMD>copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>cp", "<CMD>colder<CR>", { desc = "To older quickfix" })
map("n", "<leader>cn", "<CMD>cnewer<CR>", { desc = "To newer quickfix" })
-- remaps in quickfix window
vim.api.nvim_create_augroup('QuickFixGroup', {})
vim.api.nvim_create_autocmd('FileType', {
    group = 'QuickFixGroup',
    pattern = 'qf',
    callback = function()
        bmap(0, 'n', 'o', '<CR><C-w>p', { noremap = true })
        bmap(0, 'n', '<Tab>', 'jo', {})
        bmap(0, 'n', '<S-Tab>', 'ko', {})
        bmap(0, 'n', '<CR>', '<CR>:cclose<CR>', {})
    end
})

-- tabs
map("n", "<leader>t", ":tabnew %<CR>")
map("n", "<leader>z", "<C-w>T")
map("n", "<C-n>", "gt")
map("n", "<C-p>", "gT")
map("n", "<C-c>", "<CMD>tabclose<CR>", { desc = "Close tab" })

-- windows
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-q>", [[<C-\><C-n><C-w>q]])

-- buffers
map("n", "<BS>", "<CMD>b#<CR>", { desc = "Switch to last buffer" })

-- LSP
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })

local startMark = 'S'
map("n", "<C-]>", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gr", function() r.markAndDo(startMark, function() vim.lsp.buf.references({ includeDeclaration = false }) end) end, { desc = "References" })
map("n", "gi", function() r.markAndDo(startMark, vim.lsp.buf.implementation) end, { desc = "Implementations" })
map("n", "gT", function() r.markAndDo(startMark, vim.lsp.buf.type_definition) end, { desc = "Type definitions" })
map("n", "gh", function() r.markAndDo(startMark, vim.lsp.buf.typehierarchy) end, { desc = "Type hierarchy" })

map("n", "<leader>le", function() r.markAndDo(startMark, vim.diagnostic.open_float) end, { desc = "Inline diagnostics" })
map("n", "<leader>lE", function() r.markAndDo(startMark, vim.diagnostic.setqflist) end, { desc = "Workspace diagnostics" })

