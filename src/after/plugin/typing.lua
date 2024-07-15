local map = vim.keymap.set

require("ibl").setup()
require("nvim-surround").setup()
require('nvim-ts-autotag').setup()

-- Undotree
vim.g.undotree_CustomUndotreeCmd = 'vertical 32 new'
vim.g.undotree_CustomDiffpanelCmd= 'belowright 12 new'
map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- comments
local api = require('Comment.api')
require('Comment').setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = false,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
})
map("n", "<leader>/", api.toggle.linewise.current, { desc = "Toggle line comment" })
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle selection comment" })

-- copilot
local function acceptWord()
    vim.fn['copilot#Accept']("")
    local bar = vim.fn['copilot#TextQueuedForInsertion']()
    return vim.fn.split(bar,  [[[ *.]\zs]])[1]
end

-- remaps
map('i', '<C-f>', acceptWord, {expr = true, remap = false})

