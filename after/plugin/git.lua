local gitsigns = require('gitsigns')
local whichkey = require('which-key')

require('gitsigns').setup()

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>g',
}
local mappings = {
    name = "Git",
    j = { gitsigns.next_hunk, "Next Hunk" },
    k = { gitsigns.prev_hunk, "Prev Hunk" },
    l = { gitsigns.blame_line, "Blame" },
    u = { gitsigns.undo_stage_hunk, "Undo Stage Hunk" },
    d = { [[:DiffviewOpen<CR>]], "Open diff view" },
}
whichkey.register(mappings, opts)

