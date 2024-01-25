local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

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
