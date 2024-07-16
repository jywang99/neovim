local map = vim.keymap.set

vim.g.mapleader = " "

-- navigation
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- tabs
map("n", "<leader>z", ":tabnew %<CR>")
map("n", "<leader>Z", "<C-w>T")

-- clipboard
map("v", "<C-c>", [["+y]])
map("x", "<leader>p", [["_dP]]) -- greatest remap ever

-- options
map("n", "<leader>n", ":noh<CR>", { desc = "Clear highlights" })
map("n", "<leader>oh", ":set invhlsearch<CR>", { desc = "Toggle search highlights" })
map("n", "<leader>op", ":set invpaste<CR>", { desc = "Toggle paste mode" })
map("n", "<leader>on", ":set invnumber<CR>", { desc = "Toggle line number" })
map("n", "<leader>or", ":set invrelativenumber<CR>", { desc = "Toggle relative number" })

-- registers
local function promptAndSwap()
    -- prompt for registers
    vim.cmd('echo "Swap register: "')
    local a = vim.fn.nr2char(vim.fn.getchar())
    vim.cmd('echo "with register: "')
    local b = vim.fn.nr2char(vim.fn.getchar())

    -- swap
    local temp = vim.fn.getreg(a)
    vim.fn.setreg(a, vim.fn.getreg(b))
    vim.fn.setreg(b, temp)

    vim.cmd('echo "Swapped."')
end

map("n", "<leader>rs", promptAndSwap, { desc = "Swap registers" })

-- text manipulation
map("v", "J", ":m '>+1<CR>gv=gv") -- move line
map("v", "K", ":m '<-2<CR>gv=gv")
map('i', '<C-c>', '<Esc>O') -- newline above

-- quickfix
local function searchModifiedBufs()
    local buffers = vim.api.nvim_list_bufs()

    local quickfix_list = {}
    for _, bufnr in ipairs(buffers) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local is_modified = vim.api.nvim_buf_get_option(bufnr, 'modified')

        if is_modified then
            table.insert(quickfix_list, {filename = bufname, bufnr = bufnr})
        end
    end

    vim.fn.setqflist(quickfix_list)
    vim.cmd("copen")
end

map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })

map("n", "]q", "<CMD>cnext<CR>zz", { desc = "Forward quickfix" })
map("n", "[q", "<CMD>cprev<CR>zz", { desc = "Backward quickfix" })
map("n", "<leader>co", "<CMD>copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>cp", "<CMD>colder<CR>", { desc = "To older quickfix" })
map("n", "<leader>cn", "<CMD>cnewer<CR>", { desc = "To newer quickfix" })
map("n", "<leader>ce", searchModifiedBufs, { desc = "Show edited buffers" })

-- tabs
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

