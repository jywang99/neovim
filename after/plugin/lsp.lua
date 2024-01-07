local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jdtls', 'pyright'},
    handlers = {
        lsp_zero.deefault_setup,
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
lsp_config.pyright.setup({})

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
    if client.name == "jdt.ls" then
        require("jdtls").setup_dap { hotcodereplace = "auto" }
        require("jdtls.dap").setup_dap_main_class_configs()
        vim.lsp.codelens.refresh()
    end
end)

lsp_zero.setup()

