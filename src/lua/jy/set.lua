-- editing
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.cmd("autocmd BufEnter * set formatoptions-=cro")

-- whitespace
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

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

vim.o.shell = "/bin/zsh"

