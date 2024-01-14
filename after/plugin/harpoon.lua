local harpoon = require("harpoon")
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
local whichkey = require('which-key')
local terminal = require("harpoon.term")

harpoon.setup()

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    [';'] = { ui.toggle_quick_menu, 'Open harpoon menu' },
    h = {
        name = "Harpoon",
        p = { ui.nav_prev, "Prev harp" },
        n = { ui.nav_next, "Next harp" },
        a = { mark.add_file, "Add file" },
    },
    t = {
        ['1'] = { function() terminal.gotoTerminal(1) end, 'Terminal 1' },
        ['2'] = { function() terminal.gotoTerminal(2) end, 'Terminal 2' },
        ['3'] = { function() terminal.gotoTerminal(3) end, 'Terminal 3' },
    },
}
whichkey.register(mappings, opts)

