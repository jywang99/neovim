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
                ensure_installed = { 'tsserver', 'eslint', 'lua_ls', 'jdtls', 'pyright', 'dockerls', 'docker_compose_language_service', 'bashls', 'jsonls', 'gopls', 'clangd', 'svelte', 'omnisharp' },
                handlers = {
                    lsp_zero.default_setup,
                    jdtls = lsp_zero.noop,
                }
            })

            local lsp_config = require('lspconfig')
            lsp_config.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
            lsp_config.pyright.setup {}
            lsp_config.dockerls.setup {}
            lsp_config.docker_compose_language_service.setup {}
            lsp_config.bashls.setup {}
            lsp_config.jsonls.setup {}
            lsp_config.lemminx.setup {}
            lsp_config.clangd.setup {}

            lsp_config.gopls.setup {
                staticcheck = true,
            }

            lsp_zero.setup()
        end
    },
    {
        'Hoffs/omnisharp-extended-lsp.nvim',
        lazy = true,
        ft = { 'cs' },
        dependencies = { 'VonHeikemen/lsp-zero.nvim' },
        config = function()
            local omni_ext = require('omnisharp_extended')
            require('lspconfig').omnisharp.setup {
                handlers = {
                    ["textDocument/definition"] = omni_ext.definition_handler,
                    ["textDocument/typeDefinition"] = omni_ext.type_definition_handler,
                    ["textDocument/references"] = omni_ext.references_handler,
                    ["textDocument/implementation"] = omni_ext.implementation_handler,
                },
            }
        end
    },
}

