local lsp = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jedi_language_server', 'jdtls'},
})
require('lspconfig').lua_ls.setup({})
require('lspconfig').jedi_language_server.setup({})
require('lspconfig').jdtls.setup({})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	-- ['<C-Tab>'] = cmp.mapping.complete(),
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

