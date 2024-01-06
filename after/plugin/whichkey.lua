local status_ok, which_key = pcall(require, "which-key")
local dapui = require('dapui')
local gitsigns = require('gitsigns')

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

local function close_left_bufs()
    dapui.close()
    vim.cmd [[NvimTreeClose]]
end

local function close_right_bufs ()
    pcall(vim.cmd, 'UndotreeHide')
    pcall(vim.cmd, 'SymbolsOutlineClose')
end

local function go_to_previous_window()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>p", true, true, true), "n", true)
end

function DoAndSwitchBackWindow(func)
    local current_window = vim.fn.win_getid()
    func()
    vim.defer_fn(function()
        vim.api.nvim_set_current_win(current_window)
    end, 100)
end

local mappings = {
    -- main menu
    ["<leader>"] = {
        -- explorer
        e = {
            name = "Explorer",
            e = { function ()
                close_left_bufs()
                vim.cmd [[NvimTreeFocus]]
                go_to_previous_window()
            end, "Focus tree" },
            f = { function ()
                close_left_bufs()
                vim.cmd [[NvimTreeFindFile]]
            end, "Show file in tree" },
        },
        -- find in workspace
        f = {
            name = "Find",
            o = { "<Cmd>Telescope find_files<CR>", "Open file" },
            s = { TelescopeResume, "Live grep" },
            r = { "<Cmd>Telescope live_grep<CR>", "Live grep (reset)" },
            g = { "<Cmd>Telescope git_files<CR>", "Open git file" },
        },
        -- find/replace in file
        s = {
            c = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word" },
        },
        -- undotree
        u = { function ()
            close_right_bufs()
            vim.cmd [[UndotreeShow]]
        end, "Toggle Undotree" },
        -- symbols-outline
        o = { function ()
            DoAndSwitchBackWindow(function()
                close_right_bufs()
                vim.cmd [[SymbolsOutlineOpen]]
            end)
        end, "Toggle SymbolsOutline" },
        -- git
        g = {
            name = "Git",
            j = { gitsigns.next_hunk, "Next Hunk" },
            k = { gitsigns.prev_hunk, "Prev Hunk" },
            l = { gitsigns.blame_line, "Blame" },
            u = { gitsigns.undo_stage_hunk, "Undo Stage Hunk" },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            d = { ToggleDiffview, "Toggle diff view", },
        },
        -- LSP
        l = {
            name = "LSP",
            -- editing
            f = { vim.lsp.buf.format, "Format file" },
            r = { vim.lsp.buf.rename, "Rename" },
            -- info
            I = { vim.lsp.buf.hover, "Info" },
            c = { [[:Glance implementations<CR>]], "Implementations" },
            u = { [[:Glance references<CR>]], "References" },
            t = { [[:Glance type_definitions<CR>]], "Type definitions" },
            i = { [[:Glance implementations<CR>]], "Implementations" },
            D = { vim.diagnostic.open_float, "Diagnostics" },
        },
        -- debug
        r = {
            name = "Debug",
            i = { function ()
                close_right_bufs()
                close_left_bufs()
                dapui.open()
            end, "Show debug view" },
            -- debugging controls
            p = { [[:DapLoadLaunchJson<CR>]], "Load launch json" },
            ["<Space>"] = { [[:DapContinue<CR>]], "Resume" },
            t = { [[:DapTerminate<CR>]], "Terminate" },
            l = { [[:DapStepInto<CR>]], "Step into" },
            h = { [[:DapStepOut<CR>]], "Step out" },
            j = { [[:DapStepOver<CR>]], "Step over" },
            r = { [[:DapRestartFrame<CR>]], "Restart frame" },
        },
        -- breakpoint
        b = { [[:DapToggleBreakpoint<CR>]], "Toggle breakpoint" },
        -- terminal
        t = {
            t = { SwitchToTerm, 'Open terminal' },
            x = { KillTerm, 'Close terminal' },
        },
        -- close panes
        p = {
            name = "Close pane",
            a = { function ()
                close_right_bufs()
                close_left_bufs()
            end, "Close side panes" },
            l = { close_left_bufs, "Close left pane" },
            r = { close_right_bufs, "Close right pane" },
        }
    },
    -- buffers, some lsp
    g = {
        name = "Buffer",
        -- navigation
        [","] = { '<Cmd>BufferLineCyclePrev<CR>', "Previous tab" },
        ["."] = { '<Cmd>BufferLineCycleNext<CR>', "Next tab" },
        ["p"] = { '<Cmd>BufferLinePick<CR>', "Magic buffer-picking mode" },
        ["1"] = { '<Cmd>BufferLineGoToBuffer 1<CR>', "Goto buffer in position 1" },
        ["2"] = { '<Cmd>BufferLineGoToBuffer 2<CR>', "Goto buffer in position 2" },
        ["3"] = { '<Cmd>BufferLineGoToBuffer 3<CR>', "Goto buffer in position 3" },
        ["4"] = { '<Cmd>BufferLineGoToBuffer 4<CR>', "Goto buffer in position 4" },
        ["5"] = { '<Cmd>BufferLineGoToBuffer 5<CR>', "Goto buffer in position 5" },
        ["6"] = { '<Cmd>BufferLineGoToBuffer 6<CR>', "Goto buffer in position 6" },
        ["7"] = { '<Cmd>BufferLineGoToBuffer 7<CR>', "Goto buffer in position 7" },
        ["8"] = { '<Cmd>BufferLineGoToBuffer 8<CR>', "Goto buffer in position 8" },
        ["9"] = { '<Cmd>BufferLineGoToBuffer 9<CR>', "Goto buffer in position 9" },
        -- close buffers
        ["w"] = { '<Cmd>:bp<bar>sp<bar>bn<bar>bd<CR><CR>', "Close current" },
        k = {
            name = 'batch close buffers',
            o = { '<Cmd>BufferLineCloseOthers<CR>', "Close all but current buffer" },
            h = { '<Cmd>BufferLineCloseLeft<CR>', "Close buffers to the left" },
            l = { '<Cmd>BufferLineCloseRight<CR>', "Close buffers to the right" },
        },
        -- buffer ordering
        ["<"] = { '<Cmd>BufferLineMovePrev<CR>', "Move buffer to left" },
        [">"] = { '<Cmd>BufferLineMoveNext<CR>', "Move buffer to left" },
        o = {
            ["d"] = { '<Cmd>BufferLineSortByDirectory<CR>', "Sort automatically by directory" },
            ["e"] = { '<Cmd>BufferLineSortByExtension<CR>', "Sort automatically by extension" },
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

