local feline = require('feline')

require("catppuccin").setup({
    color_overrides = {
        mocha = {
            base = "#191926",
        },
    },
})

vim.cmd.colorscheme('catppuccin')

feline.setup({
    disable = {
        filetypes = {
            'dap'
        },
    },
})
feline.winbar.setup()
