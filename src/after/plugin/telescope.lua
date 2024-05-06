local telescope = require('telescope')
local builtin = require('telescope.builtin')
local whichkey = require('which-key')

telescope.setup({
    defaults = {
        cache_picker = {
            num_pickers = -1,
        },
        path_display = { "truncate" },
        dynamic_preview_title = true,
    },
    pickers = {
        find_files = {
            hidden = false
        }
    }
})
telescope.load_extension('dap')

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    f = {
        name = "Telescope",
        -- current buffer
        s = { builtin.current_buffer_fuzzy_find, "Search in current buffer" },
        -- workspace
        o = { builtin.find_files, "Open file" },
        h = { builtin.oldfiles, "Recent files" },
        S = { builtin.live_grep, "Live grep" },
        r = { builtin.resume, "Resume last search" },
        p = { builtin.pickers, "Previous search" },
        b = { builtin.buffers, "Find buffer" },
        -- others
        f = { builtin.builtin, "Pick a picker" },
    },
}
whichkey.register(mappings, opts)

