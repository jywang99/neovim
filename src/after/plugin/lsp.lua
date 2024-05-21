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

    -- keymaps when LSP is active
    local lspOpts = {
        mode = "n",
        prefix = 'g'
    }
    local tsOpts = {
        include_declaration = false,
        trim_text = true,
        fname_width = 25,
    }
    local lspMap = {
        d = { function() telescope.lsp_definitions(tsOpts) end, "Definitions" },
        c = { function() telescope.lsp_implementations(tsOpts) end, "Implementations" },
        r = { function() telescope.lsp_references(tsOpts) end, "References" },
        T = { function() telescope.type_definitions(tsOpts) end, "Type definitions" },
    }
    whichkey.register(lspMap, lspOpts)
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
    s = { telescope.lsp_document_symbols, "Symbols in file" },
    S = { telescope.lsp_workspace_symbols, "Symbols in file" },
    e = { vim.diagnostic.open_float, "Inline diagnostics" },
    E = { function() sidebar.nukeAndRun(function() trouble.toggle('workspace_diagnostics') end) end, "Project diagnostics" },
}
whichkey.register(mappings, opts)

local opts3 = {
    mode = "n",
}
local mappings3 = {
    name = "LSP diagnostics",
    ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
    ["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
}
whichkey.register(mappings3, opts3)
