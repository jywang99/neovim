local api = require('Comment.api')
local whichkey = require('which-key')

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

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    ['/'] = { api.toggle.linewise.current, 'Toggle line comment' },
}
whichkey.register(mappings, opts)

local v_opts = {
    mode = "v",     -- NORMAL mode
    prefix = '<leader>',
}
local v_mappings = {
    ['/'] = { '<Plug>(comment_toggle_linewise_visual)', 'Toggle selection comment' },
}
whichkey.register(v_mappings, v_opts)

