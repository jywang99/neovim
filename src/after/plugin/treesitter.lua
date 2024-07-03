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
}

context.setup {
    line_numbers = true,
    max_lines = 5,
    multiline_threshold = 1,
    trim_scope = 'outer',
    separator = '-',
    zindex = 20, -- The Z-index of the context window
}

