local lsp = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jedi_language_server', 'jdtls'},
})
require('lspconfig').lua_ls.setup({})
require('lspconfig').jedi_language_server.setup({})
require('lspconfig').jdtls.setup({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

