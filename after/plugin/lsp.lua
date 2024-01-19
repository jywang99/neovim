local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local telescope = require('telescope.builtin')
local whichkey = require('which-key')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jdtls', 'pyright' },
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
lsp_config.csharp_ls.setup({})

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    if client.name == "jdt.ls" then
        require("jdtls").setup_dap { hotcodereplace = "auto" }
        require("jdtls.dap").setup_dap_main_class_configs()
        vim.lsp.codelens.refresh()
    end
end)

lsp_zero.setup()

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>l',
}
local mappings = {
    name = "LSP",
    -- editing
    f = { vim.lsp.buf.format, "Format file" },
    r = { vim.lsp.buf.rename, "Rename" },
    -- info
    I = { vim.lsp.buf.hover, "Info" },
    d = { telescope.lsp_definitions, "Definitions" },
    c = { telescope.lsp_implementations, "Implementations" },
    u = { telescope.lsp_references, "References" },
    t = { telescope.type_definitions, "Type definitions" },
    s = { telescope.lsp_document_symbols, "Symbols in file" },
    S = { telescope.lsp_workspace_symbols, "Symbols in file" },
    D = { vim.diagnostic.open_float, "Diagnostics" },
}
whichkey.register(mappings, opts)

