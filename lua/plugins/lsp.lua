return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            require('mason-lspconfig').setup({
                ensure_installed = { 'eslint', 'lua_ls', 'pyright', 'dockerls', 'docker_compose_language_service', 'bashls', 'jsonls', 'gopls', 'clangd', 'svelte', 'omnisharp' },
                handlers = {
                    lsp_zero.default_setup,
                }
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })

            lsp_zero.setup()
        end
    },
    {
        'nvim-java/nvim-java',
        ft = { 'java' },
        config = function()
            require('java').setup()
            require('lspconfig').jdtls.setup({})
        end
    }
}

