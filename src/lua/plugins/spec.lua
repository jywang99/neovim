return {
    -- navigation
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    'ThePrimeagen/harpoon',
    'stevearc/oil.nvim',

    -- UI/UX
    'folke/which-key.nvim',
    { 'catppuccin/nvim', name = 'catppuccin' },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    { 'echasnovski/mini.icons', lazy = true },
    'nvim-telescope/telescope-dap.nvim',
    {
	    'nvim-lualine/lualine.nvim',
	    dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- editing
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'mbbill/undotree',
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
    },
    'lukas-reineke/indent-blankline.nvim',
    'numToStr/Comment.nvim',
    'cohama/lexima.vim',
    'windwp/nvim-ts-autotag',
    'dkarter/bullets.vim',

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    },

    -- Debug
    { 'theHamsta/nvim-dap-virtual-text', lazy = true },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        lazy = true,
    },

    -- languages
    { 'mfussenegger/nvim-jdtls', lazy = true },
    {
        'mfussenegger/nvim-dap-python',
        lazy = true,
        dependencies = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui'
        },
        config = function(_, opts)
            require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        end
    },
    { 'leoluz/nvim-dap-go', lazy = true },
    { 'Hoffs/omnisharp-extended-lsp.nvim', lazy = true },

    -- Git
    'lewis6991/gitsigns.nvim',
    'sindrets/diffview.nvim',
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = true,
    },

    -- Copilot
    'github/copilot.vim'
}
