local gitsigns = require('gitsigns')
local diffview = require('diffview')
local neogit = require('neogit')
local map = vim.keymap.set

require('gitsigns').setup()

diffview.setup({
    view = {
        merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_mixed",
            disable_diagnostics = false,
        },
    }
})

local function diffFileWithRef()
    local ref = vim.fn.input('Ref: ')
    if ref == nil or ref == '' then
        return
    end
    local cmd = 'DiffviewOpen ' .. ref .. ' -- %'
    vim.cmd(cmd)
end

-- set whichkey title for <leader>g
map("n", "<leader>gg", neogit.open, { desc = "Open Neogit" })
map("n", "<leader>gl", gitsigns.blame_line, { desc = "Blame" })
map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
map("n", "<leader>gd", [[:DiffviewOpen<CR>]], { desc = "Open diff view" })
map("n", "<leader>gD", diffFileWithRef, { desc = "Diff file with ref" })
map("n", "<leader>gh", [[:DiffviewFileHistory %<CR>]], { desc = "Open git history" })

map("n", "]g", gitsigns.next_hunk, { desc = "Next Git Hunk" })
map("n", "[g", gitsigns.prev_hunk, { desc = "Previous Git Hunk" })

