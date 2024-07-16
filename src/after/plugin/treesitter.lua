local context = require('treesitter-context')

require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "javascript", "typescript", "c", "lua", "python", "c_sharp" },

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
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer",
            },
            selection_modes = {
                ['@function.inner'] = 'V',
                ['@function.outer'] = 'V',
                ['@class.outer'] = 'V',
                ["@block.inner"] = 'v',
                ["@block.outer"] = 'V',
            },
        },
    },
}

context.setup {
    line_numbers = true,
    max_lines = 5,
    multiline_threshold = 1,
    trim_scope = 'outer',
    separator = '-',
    zindex = 20, -- The Z-index of the context window
}

-- repeat movements
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
local map = vim.keymap.set
-- make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

