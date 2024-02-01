-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- navigation
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use 'nvim-telescope/telescope-dap.nvim'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }
    use 'nvim-tree/nvim-web-devicons'
    use 'yorickpeterse/nvim-window'
    use 'ThePrimeagen/harpoon'

    -- UI/UX
    use 'feline-nvim/feline.nvim'
    use 'folke/which-key.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use { 'Mofiqul/vscode.nvim', as = 'vscode' }
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- editing
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }
    use 'mbbill/undotree'
    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    }
    use 'numToStr/Comment.nvim'
    use 'm4xshen/autoclose.nvim'
    use 'dkarter/bullets.vim'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use {
        "olexsmir/gopher.nvim",
        requires = { -- dependencies
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    }

    -- Debug
    use 'theHamsta/nvim-dap-virtual-text'
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
    use 'mfussenegger/nvim-jdtls'
    use {
        'mfussenegger/nvim-dap-python',
        requires = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui'
        },
        config = function(_, opts)
            require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        end
    }
    use 'leoluz/nvim-dap-go'

    -- Git
    use('lewis6991/gitsigns.nvim')
    use "sindrets/diffview.nvim"

    -- DB
    use {
        'kristijanhusak/vim-dadbod-ui',
        requires = {
            'tpope/vim-dadbod',
            'kristijanhusak/vim-dadbod-completion',
        },
    }
    use 'kristijanhusak/vim-dadbod-completion'
end)
