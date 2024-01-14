local harpoon = require("harpoon")
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
local whichkey = require('which-key')

harpoon.setup()
require("telescope").load_extension('harpoon')

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
}
whichkey.register(mappings, opts)

