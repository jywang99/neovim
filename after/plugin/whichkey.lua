local vim = vim
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true,         -- shows a list of your marks on ' and `
        registers = true,     -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },                                           -- min and max height of the columns
        width = { min = 20, max = 50 },                                           -- min and max width of the columns
        spacing = 3,                                                              -- spacing between columns
        align = "left",                                                           -- align columns left, center or right
    },
    ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}
which_key.setup(setup)

local opts = {
    mode = "n",     -- NORMAL mode
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
    -- main menu
    ["<leader>"] = {
        -- explorer
        e = {
            name = "Explorer",
            e = { "<Cmd>NvimTreeFocus<CR>", "Focus tree" },
            f = { "<Cmd>NvimTreeFindFile<CR>", "Show file in tree" },
            t = { "<Cmd>NvimTreeToggle<CR>", "Toggle file in tree" },
        },
        -- find in workspace
        f = {
            name = "Find",
            o = { "<Cmd>Telescope find_files<CR>", "Open file" },
            s = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
            g = { "<Cmd>Telescope git_files<CR>", "Open git file" },
        },
        -- find/replace in file
        s = {
            c = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word" },
        },
        -- undotree
        u = { "<Cmd>UndotreeToggle<CR>", "Toggle Undotree" },
        -- symbols-outline
        o = { "<Cmd>SymbolsOutline<CR>", "Toggle SymbolsOutline" },
        -- git
        g = {
            name = "Git",
            i = { "<cmd>lua ToggleLazyGit()<CR>", "LazyGit" },
        },
        -- LSP
        l = {
            -- editing
            f = { vim.lsp.buf.format, "Format file" },
            r = { vim.lsp.buf.rename, "Rename" },
            -- info
            i = { vim.lsp.buf.hover, "Info" },
            c = { vim.lsp.buf.implementation, "Implementations" },
            u = { vim.lsp.buf.references, "References" },
            d = { vim.diagnostic.open_float, "Diagnostics" },
        },
    },
    -- buffers, some lsp
    ["g"] = {
        name = "Buffer",
        -- navigation
        [","] = { '<Cmd>BufferPrevious<CR>', "Previous tab" },
        ["."] = { '<Cmd>BufferNext<CR>', "Next tab" },
        ["p"] = { '<Cmd>BufferPick<CR>', "Magic buffer-picking mode" },
        ["1"] = { '<Cmd>BufferGoto 1<CR>', "Goto buffer in position 1" },
        ["2"] = { '<Cmd>BufferGoto 2<CR>', "Goto buffer in position 2" },
        ["3"] = { '<Cmd>BufferGoto 3<CR>', "Goto buffer in position 3" },
        ["4"] = { '<Cmd>BufferGoto 4<CR>', "Goto buffer in position 4" },
        ["5"] = { '<Cmd>BufferGoto 5<CR>', "Goto buffer in position 5" },
        ["6"] = { '<Cmd>BufferGoto 6<CR>', "Goto buffer in position 6" },
        ["7"] = { '<Cmd>BufferGoto 7<CR>', "Goto buffer in position 7" },
        ["8"] = { '<Cmd>BufferGoto 8<CR>', "Goto buffer in position 8" },
        ["9"] = { '<Cmd>BufferGoto 9<CR>', "Goto buffer in position 9" },
        ["0"] = { '<Cmd>BufferLast<CR>', "Goto last buffer" },
        -- ["p"] = { '<Cmd>BufferPin<CR>', "Pin/unpin buffer" },
        -- close buffers
        ["w"] = { '<Cmd>BufferClose<CR>', "Close current" },
        ["ka"] = { '<Cmd>BufferWipeout<CR>', "Wipeout buffer" },
        ["ko"] = { '<Cmd>BufferCloseAllButCurrent<CR>', "Close all but current buffer" },
        ["kh"] = { '<Cmd>BufferCloseBuffersLeft<CR>', "Close buffers to the left" },
        ["kl"] = { '<Cmd>BufferCloseBuffersRight<CR>', "Close buffers to the right" },
        -- buffer ordering
        ["<"] = { '<Cmd>BufferMovePrevious<CR>', "Re-order to previous buffer" },
        [">"] = { '<Cmd>BufferMoveNext<CR>', "Re-order to next buffer" },
        o = {
            ["b"] = { '<Cmd>BufferOrderByBufferNumber<CR>', "Sort automatically by buffer number" },
            ["d"] = { '<Cmd>BufferOrderByDirectory<CR>', "Sort automatically by directory" },
            ["l"] = { '<Cmd>BufferOrderByLanguage<CR>', "Sort automatically by language" },
            ["w"] = { '<Cmd>BufferOrderByWindowNumber<CR>', "Sort automatically by window number" },
        },
        -- lsp
        d = { '<Cmd>lua vim.lsp.buf.definition()<CR>', "Go to definition" },
        D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', "Go to declaration" },
    }
}
which_key.register(mappings, opts)

local v_opts = {
    mode = "v",     -- NORMAL mode
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}
local v_mappings = {
    ["<leader>"] = {
        s = { [["hy:%s/<C-r>h//gc<left><left><left>]], "Find and replace" },
    }
}
which_key.register(v_mappings, v_opts)

