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

-- language-specifics

local dap = require('dap')
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

-- go
require('dap-go').setup {
    dap_configurations = {
        {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
        },
    },
    -- delve configurations
    delve = {
        args = {},
        -- the build flags that are passed to delve.
        -- defaults to empty string, but can be used to provide flags
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        build_flags = "",
    },
}

-- these languages tend to be deeply nested
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.html", "*.svelte" },
    command = "setlocal ts=2 sts=2 sw=2 expandtab",
})

-- csharp
dap.adapters.coreclr = {
	type = 'executable',
	command = '/usr/lib/netcoredbg/netcoredbg',
	args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
		end,
	},
}

-- perl
configs.perlpls = {
	default_config = {
		cmd = { 'pls' },
		filetypes = { "perl" },
		root_dir = function(fname)
			return util.root_pattern(".git")(fname) or vim.fn.getcwd()
		end,
	},
	docs = {
		package_json = "",
		description = [[ ]],
		default_config = {
			root_dir = "vim's starting directory",
		},
	},
};

configs.perlpls.setup{}

-- python
dap.adapters.python = {
    type = 'executable',
    command = 'python3',
    args = {'-m', 'debugpy.adapter'}
}
dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function() return '/usr/bin/python3' end,
    },
}

