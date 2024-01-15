local zen = require("zen-mode")
local whichkey = require('which-key')

function ToggleZen()
    zen.toggle({
        window = {
            width = .85 -- width will be 85% of the editor width
        }
    })
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    z = { ToggleZen, 'Toggle Zen mode' },
}
whichkey.register(mappings, opts)

