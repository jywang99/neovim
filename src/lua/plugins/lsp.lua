return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jdtls', 'pyright', 'dockerls', 'docker_compose_language_service', 'bashls', 'jsonls', 'gopls', 'clangd', 'svelte', 'omnisharp' },
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

            lsp_config.gopls.setup {
                staticcheck = true,
            }

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                if client.name == "jdt.ls" then
                    require("jdtls").setup_dap { hotcodereplace = "auto" }
                    require("jdtls.dap").setup_dap_main_class_configs()
                    vim.lsp.codelens.refresh()
                end
            end)

            lsp_zero.setup()
        end
    },

    -- languages
    {
        'Hoffs/omnisharp-extended-lsp.nvim',
        lazy = true,
        ft = { 'cs' },
        dependencies = { 'neovim/nvim-lspconfig' },
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

