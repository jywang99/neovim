return {
    { 'echasnovski/mini.icons', lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    {
        'folke/which-key.nvim',
        config = function()
            local status_ok, whichkey = pcall(require, "which-key")

            if not status_ok then
                return
            end

            whichkey.setup({})

            whichkey.add({ '<leader>g', group = 'Git' })
            whichkey.add({ '<leader>f', group = 'Telescope' })
            whichkey.add({ '<leader>c', group = 'Quickfix' })
            whichkey.add({ '<leader>d', group = 'Debug' })
            whichkey.add({ '<leader>l', group = 'LSP', icon = '🧠' })
            whichkey.add({ '<leader>o', group = 'Options', icon = '⚙️' })
        end
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require("catppuccin").setup({
                color_overrides = {
                    mocha = {
                        base = "#191926",
                    },
                },
            })
            vim.cmd.colorscheme('catppuccin')
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        lazy = true,
        ft = { 'markdown' },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local line = require('lualine')
            line.setup {}

        end
    },
}
