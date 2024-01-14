local sidebar = require('util.sidebar')

local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
    return
end

which_key.setup({})

local opts = {
    mode = "n",     -- NORMAL mode
    buffer = nil,   -- global mappings. specify a buffer number for buffer local mappings
}
local mappings = {
    -- main menu
    ["<leader>"] = {
        -- window switcher
        w = { require('nvim-window').pick, 'Jump to window' },
        -- undotree
        u = { function ()
            sidebar.closeRightBufs()
            vim.cmd [[UndotreeShow]]
        end, "Toggle Undotree" },
        -- close panes
        p = {
            name = "Close pane",
            a = { sidebar.nukePeripherals, "Close side panes" },
            l = { sidebar.closeLeftBufs, "Close left pane" },
            r = { sidebar.closeRightBufs, "Close right pane" },
        }
    },
}
which_key.register(mappings, opts)

