-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- navigation
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use 'nvim-tree/nvim-web-devicons'
    use 'ThePrimeagen/harpoon'
    use 'stevearc/oil.nvim'

    -- UI/UX
    use 'feline-nvim/feline.nvim'
    use 'folke/which-key.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use 'echasnovski/mini.icons'

    -- editing
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use 'mbbill/undotree'
    use {
        'kylechui/nvim-surround',
        tag = '*', -- Use for stability; omit to use `main` branch for the latest features
    }
    use 'lukas-reineke/indent-blankline.nvim'
    use 'numToStr/Comment.nvim'
    use 'cohama/lexima.vim'
    use 'windwp/nvim-ts-autotag'
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

    -- Debug
    use 'theHamsta/nvim-dap-virtual-text'
    use {
        'rcarriga/nvim-dap-ui',
        requires = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'},
        commit = '5934302' -- TODO remove when the PR is merged
    }
    use 'nvim-telescope/telescope-dap.nvim'
    -- languages
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
    use 'lewis6991/gitsigns.nvim'
    use 'sindrets/diffview.nvim'
    use {
        'NeogitOrg/neogit',
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = true,
    }

    -- Copilot
    use 'github/copilot.vim'
end)
