local dapui = require('dapui')
local gitsigns = require('gitsigns')
local comment = require('Comment.api')
local sidebar = require('util.sidebar')

local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
    return
end

which_key.setup({})

local opts = {
    mode = "n",     -- NORMAL mode
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}

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
                sidebar.closeLeftBufs()
                vim.cmd [[NvimTreeFocus]]
                go_to_previous_window()
            end, "Focus tree" },
            f = { function ()
                sidebar.closeLeftBufs()
                vim.cmd [[NvimTreeFindFile]]
            end, "Show file in tree" },
        },
        -- window switcher
        w = { require('nvim-window').pick, 'Jump to window' },
        -- find in workspace
        f = {
            name = "Find",
            o = { "<Cmd>Telescope find_files<CR>", "Open file" },
            r = { TelescopeResume, "Resume last search" },
            s = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
            g = { "<Cmd>Telescope git_files<CR>", "Open git file" },
        },
        -- find/replace in file
        s = {
            c = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word" },
        },
        -- undotree
        u = { function ()
            sidebar.closeRightBufs()
            vim.cmd [[UndotreeShow]]
        end, "Toggle Undotree" },
        -- symbols-outline
        o = { function ()
            DoAndSwitchBackWindow(function()
                sidebar.closeRightBufs()
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
        -- Comments
        ['/'] = { comment.toggle.linewise.current, 'Toggle line comment' },
        -- debug
        d = {
            name = "Debug",
            i = { function ()
                sidebar.nukeAndRun(dapui.open)
            end, "Show debug view" },
            -- breakpoint
            b = { [[:DapToggleBreakpoint<CR>]], "Toggle breakpoint" },
            c = { SetConditionalBreakpoint, "Set conditional breakpoint" },
            L = { SetLoggingBreakpoint, "Set logging breakpoint" },
            H = { SetHitCountBreakpoint, "Set hit count breakpoint" },
            -- debugging controls
            J = { [[:DapLoadLaunchJson<CR>]], "Load launch json" },
            ["<Space>"] = { [[:DapContinue<CR>]], "Resume" },
            t = { [[:DapTerminate<CR>]], "Terminate" },
            l = { [[:DapStepInto<CR>]], "Step into" },
            h = { [[:DapStepOut<CR>]], "Step out" },
            j = { [[:DapStepOver<CR>]], "Step over" },
            r = { [[:DapRestartFrame<CR>]], "Restart frame" },
        },
        -- terminal
        t = {
            t = { CreateAndSwitchToTerm, 'Open terminal' },
            m = { function() CloseTerm(false) end, 'Hide terminal' },
            x = { function() CloseTerm(true) end, 'Kill terminal' },
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
    },
    -- Comments
    ['/'] = { '<Plug>(comment_toggle_linewise_visual)', 'Toggle line comment' },
}
which_key.register(v_mappings, v_opts)

