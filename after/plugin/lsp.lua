local vim = vim
local lsp = require('lsp-zero')

lsp.preset('recommended')

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jdtls'},
})
require('lspconfig').lua_ls.setup({})
require('lspconfig').jedi_language_server.setup({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})

   local opts = {buffer = bufnr, remap = false}
   if client.name == "jdt.ls" then
       require("jdtls").setup_dap { hotcodereplace = "auto" }
       require("jdtls.dap").setup_dap_main_class_configs()
       vim.lsp.codelens.refresh()
   end
end)

lsp.setup()

