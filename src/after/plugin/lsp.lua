local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local telescope = require('telescope.builtin')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jdtls', 'pyright', 'dockerls', 'docker_compose_language_service', 'bashls', 'jsonls', 'gopls', 'clangd', 'svelte' },
    handlers = {
        lsp_zero.default_setup,
        jdtls = lsp_zero.noop,
    }
})
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
lsp_config.csharp_ls.setup {}
lsp_config.dockerls.setup {}
lsp_config.docker_compose_language_service.setup {}
lsp_config.bashls.setup {}
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- require 'lspconfig'.jsonls.setup {
--     capabilities = capabilities,
-- }
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

local tsOpts = {
    include_declaration = false,
    trim_text = true,
    fname_width = 25,
}

-- keybindings
local map = vim.keymap.set
map("n", "<leader>lf", function() vim.lsp.buf.formatting() end, { desc = "Format file" })
map("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "Rename" })
map("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Code actions" })
map("n", "<leader>ls", function() telescope.lsp_document_symbols(tsOpts) end, { desc = "Symbols in file" })
map("n", "<leader>lS", function() telescope.lsp_workspace_symbols(tsOpts) end, { desc = "Symbols in workspace" })
map("n", "<leader>le", function() vim.diagnostic.open_float() end, { desc = "Inline diagnostics" })
map("n", "<leader>lE", function() telescope.diagnostics() end, { desc = "Workspace diagnostics" })

map("n", "gr", function() telescope.lsp_references(tsOpts) end, { desc = "References" })
map("n", "gT", function() telescope.lsp_type_definitions(tsOpts) end, { desc = "Type definitions" })
map("n", "gi", function() telescope.lsp_implementations(tsOpts) end, { desc = "Implementations" })

map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })

