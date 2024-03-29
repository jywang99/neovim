local harpoon = require("harpoon")
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
local whichkey = require('which-key')
local terminal = require("harpoon.term")
local vimUtil = require('util.vimUtil')

harpoon.setup()

local function gotoTermWithPrompt()
    terminal.gotoTerminal(vimUtil.inputNumber("Go to terminal index: "))
end

local function gotoHarpWithPrompt()
    ui.nav_file(vimUtil.inputNumber("Go to harpoon buffer index: "))
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    ['1'] = { function() ui.nav_file(1) end, "Go to harp 1" },
    ['2'] = { function() ui.nav_file(2) end, "Go to harp 2" },
    ['3'] = { function() ui.nav_file(3) end, "Go to harp 3" },
    ['4'] = { function() ui.nav_file(4) end, "Go to harp 4" },
    ['5'] = { function() ui.nav_file(5) end, "Go to harp 5" },
    ['<Tab>'] = { gotoHarpWithPrompt, "Go to harp N" },
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
        p = { gotoTermWithPrompt, 'Terminal N' },
    },
}
whichkey.register(mappings, opts)
