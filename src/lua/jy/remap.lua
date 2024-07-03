local map = vim.keymap.set

vim.g.mapleader = " "

-- text manipulation
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- navigation
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- clipboard
map({ "v" }, "<C-c>", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("n", "<leader>P", [["+P]])
map({ "n", "v" }, "<leader>d", [["_d]])
-- greatest remap ever
map("x", "<leader>p", [["_dP]])

map("n", "Q", "<nop>")

-- insert mode
map('i', '<C-c>', '<Esc>O', { noremap = true, silent = true })

-- Terminal
local opts = { noremap = true }
-- escape
map("t", "<C-w>", [[<C-\><C-n><C-w>]])
map("t", "<C-e>", [[<C-\><C-n>]], opts)
map("t", "<C-q>", [[<C-\><C-n><C-w>q]], opts)
-- window
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

