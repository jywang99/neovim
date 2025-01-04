local map = vim.keymap.set

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("jy.workspace").loadWorkspace()
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            local context = require('treesitter-context')

            context.setup {
                line_numbers = true,
                max_lines = 5,
                multiline_threshold = 1,
                trim_scope = 'outer',
                separator = '-',
                zindex = 20, -- The Z-index of the context window
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = { "javascript", "typescript", "c", "lua", "python", "c_sharp", "java", "go", "rasi", "hyprlang" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gn", -- Start selection
                        node_incremental = "gn", -- Increment to the upper named parent
                        scope_incremental = "gc", -- Increment to the upper scope (as defined in locals.scm)
                        node_decremental = "gm", -- Decrement to the previous node
                    },
                },
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]k"] = "@class.outer",
                            ["]b"] = "@block.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]K"] = "@class.outer",
                            ["]B"] = "@block.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[k"] = "@class.outer",
                            ["[b"] = "@block.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[K"] = "@class.outer",
                            ["[B"] = "@block.outer",
                        },
                    },
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ak"] = "@class.outer",
                            ["ik"] = "@class.inner",
                            ["ib"] = "@block.inner",
                            ["ab"] = "@block.outer",
                        },
                        selection_modes = {
                            ['@function.inner'] = 'V',
                            ['@function.outer'] = 'V',
                            ['@class.outer'] = 'V',
                            ['@class.inner'] = 'V',
                            ["@block.inner"] = 'v',
                            ["@block.outer"] = 'V',
                        },
                    },
                },
            }

            -- repeat movements
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
            -- make builtin f, F, t, T also repeatable with ; and ,
            map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.g.undotree_CustomUndotreeCmd = 'vertical 32 new'
            vim.g.undotree_CustomDiffpanelCmd= 'belowright 12 new'
            map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle Undotree" })
        end
    },
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup()
        end
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("ibl").setup()
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            -- comments
            local api = require('Comment.api')
            require('Comment').setup({
                ---Add a space b/w comment and the line
                padding = true,
                ---Whether the cursor should stay at its position
                sticky = true,
                ---Lines to be ignored while (un)comment
                ignore = nil,
                ---Enable keybindings
                ---NOTE: If given `false` then the plugin won't create any mappings
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = false,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = false,
                },
                ---Function to call before (un)comment
                pre_hook = nil,
                ---Function to call after (un)comment
                post_hook = nil,
            })
            map("n", "<leader>/", api.toggle.linewise.current, { desc = "Toggle line comment" })
            map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle selection comment" })
        end
    },
    'cohama/lexima.vim',
    {
        'windwp/nvim-ts-autotag',
        lazy = true,
        ft = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte' },
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },
    {
	'dkarter/bullets.vim',
	lazy = true,
	ft = { 'md' },
    },
    {
        'github/copilot.vim',
        config = function()
            local function acceptWord()
                vim.fn['copilot#Accept']("")
                local bar = vim.fn['copilot#TextQueuedForInsertion']()
                return vim.fn.split(bar,  [[[ *.]\zs]])[1]
            end
            map('i', '<C-f>', acceptWord, {expr = true, remap = false})
        end
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
    },
}

