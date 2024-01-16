local feline = require('feline')
vim.cmd.colorscheme("vscode")

feline.setup({
    disable = {
        filetypes = {
            'dap'
        },
    },
})
feline.winbar.setup()

