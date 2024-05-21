local map = vim.keymap.set

vim.g.mapleader = " "

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- map({ "n", "v" }, "<leader>y", [["+y]])
-- clipboard
map({ "v" }, "<C-c>", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("n", "<leader>P", [["+P]])

-- map({ "n", "v" }, "<leader>d", [["_d]])

map("n", "Q", "<nop>")
-- map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- map("n", "<C-k>", "<cmd>cnext<CR>zz")
-- map("n", "<C-j>", "<cmd>cprev<CR>zz")
-- map("n", "<leader>k", "<cmd>lnext<CR>zz")
-- map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

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

