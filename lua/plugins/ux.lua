return {
    { 'echasnovski/mini.icons', lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    {
        'folke/which-key.nvim',
        config = function()
            local status_ok, wk = pcall(require, "which-key")

            if not status_ok then
                return
            end

            wk.setup({})

            wk.add({ '<leader>g', group = 'Git' })
            wk.add({ '<leader>f', group = 'Telescope' })
            wk.add({ '<leader>c', group = 'Quickfix' })
            wk.add({ '<leader>d', group = 'Debug' })
            wk.add({ '<leader>l', group = 'LSP', icon = '🧠' })
            wk.add({ '<leader>o', group = 'Options', icon = '⚙️' })
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
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local line = require('lualine')

            line.setup {
                options = {
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {{ 'encoding', show_bomb = true, }, 'fileformat', 'filetype'},
                    lualine_z = {'progress', 'location'},
                },
            }
        end
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
}
