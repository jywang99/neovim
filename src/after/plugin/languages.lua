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

require("gopher").setup {
    commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "~/go/bin/gotests", -- also you can set custom command path
        impl = "impl",
        iferr = "iferr",
    },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go' },
    desc = 'Keybindings for Go',
    callback = function()
        -- setKeymaps()
    end,
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

