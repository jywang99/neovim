-- editing
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.cmd("autocmd BufEnter * set formatoptions-=cro")

-- whitespace
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.html", "*.svelte" },
    command = "setlocal ts=2 sts=2 sw=2 expandtab",
})

-- appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3

-- backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- behavior
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- splits
vim.opt.splitkeep = 'topline'
vim.opt.equalalways = true

-- terminal
vim.o.shell = "/bin/bash"

