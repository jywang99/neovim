local map = vim.keymap.set

vim.g.mapleader = " "

-- text manipulation
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- navigation
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzv")
map("n", "N", "Nzv")

-- tabs
map("n", "<leader>z", ":tabnew %<CR>")
map("n", "<leader>Z", "<C-w>T")

-- clipboard
map("v", "<C-c>", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("n", "<leader>P", [["+P]])
map({ "n", "v" }, "<leader>d", [["_d]])
map("x", "<leader>p", [["_dP]]) -- greatest remap ever

-- options
map("n", "<leader>n", ":noh<CR>", { desc = "Clear highlights" })
map("n", "<leader>oh", ":set invhlsearch<CR>", { desc = "Toggle search highlights" })
map("n", "<leader>op", ":set invpaste<CR>", { desc = "Toggle paste mode" })
map("n", "<leader>on", ":set invnumber<CR>", { desc = "Toggle line number" })
map("n", "<leader>or", ":set invrelativenumber<CR>", { desc = "Toggle relative number" })

-- insert mode
map('i', '<C-c>', '<Esc>O', { noremap = true, silent = true })

