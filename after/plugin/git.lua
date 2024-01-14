local bufUtils = require('util.buffers')
local gitsigns = require('gitsigns')
local whichkey = require('which-key')

require('gitsigns').setup()

function ToggleDiffview()
    if bufUtils.getPartialFilenameBuffer('diffview') < 0 then
        vim.api.nvim_command(':DiffviewOpen')
        return
    end
    vim.api.nvim_command(':DiffviewClose')
end

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
    d = { ToggleDiffview, "Toggle diff view", },
}
whichkey.register(mappings, opts)

