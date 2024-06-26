local gitsigns = require('gitsigns')
local whichkey = require('which-key')
local diffview = require('diffview')
local neogit = require('neogit')

require('gitsigns').setup()
neogit.setup({})

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

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>g',
}
local mappings = {
    name = "Git",
    g = { neogit.open, "Open Neogit" },
    l = { gitsigns.blame_line, "Blame" },
    p = { gitsigns.preview_hunk, "Preview Hunk" },
    d = { [[:DiffviewOpen<CR>]], "Open diff view" },
    D = { diffFileWithRef, "Diff file with ref" },
    h = { [[:DiffviewFileHistory %<CR>]], "Open git history" },
    H = { [[:DiffviewFileHistory<CR>]], "Open git history" },
}
whichkey.register(mappings, opts)

opts = {
    mode = "n",
}
mappings = {
    [']g'] = { gitsigns.next_hunk, "Next Hunk" },
    ['[g'] = { gitsigns.prev_hunk, "Prev Hunk" },
}
whichkey.register(mappings, opts)
