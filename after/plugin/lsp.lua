local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local telescope = require('telescope.builtin')
local whichkey = require('which-key')
local trouble = require('trouble')
local sidebar = require('util.sidebar')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'jdtls', 'pyright', 'dockerls', 'docker_compose_language_service', 'bashls', 'jsonls', 'gopls', 'clangd' },
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
lsp_config.jsonls.setup{}
lsp_config.lemminx.setup{}
lsp_config.gopls.setup{
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
    a = { vim.lsp.buf.code_action, "Code actions" },
    -- info
    I = { vim.lsp.buf.hover, "Info" },
    d = { function() sidebar.nukeAndRun(function() trouble.toggle('lsp_definitions') end) end, "Definitions" },
    c = { function() sidebar.nukeAndRun(function() trouble.toggle('lsp_implementations') end) end, "Implementations" },
    u = { function() sidebar.nukeAndRun(function() trouble.toggle('lsp_references') end) end, "References" },
    t = { function() sidebar.nukeAndRun(function() trouble.toggle('type_definitions') end) end, "Type definitions" },
    s = { telescope.lsp_document_symbols, "Symbols in file" },
    S = { telescope.lsp_workspace_symbols, "Symbols in file" },
    e = { vim.diagnostic.open_float, "Inline diagnostics" },
    E = { function() trouble.toggle('workspace_diagnostics') end, "Project diagnostics" },
}
whichkey.register(mappings, opts)

local opts2 = {
    mode = "n",
}
local mappings2 = {
    name = "LSP diagnostics",
    ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
    ["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
}
whichkey.register(mappings2, opts2)
