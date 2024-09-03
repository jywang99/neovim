-- editing
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.cmd("autocmd BufEnter * set formatoptions-=cro")

-- whitespace
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*" },
    command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.html", "*.svelte" },
    command = "setlocal ts=2 sts=2 sw=2 expandtab",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.man" },
    command = "setlocal ft=man relativenumber number",
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

-- terminal
vim.o.shell = "/bin/bash"

