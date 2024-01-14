local telescope = require('telescope')
local builtin = require('telescope.builtin')
local whichkey = require('which-key')

telescope.setup({
    defaults = {
        cache_picker = {
            num_pickers = -1,
        },
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
        o = { builtin.find_files, "Open file" },
        h = { builtin.oldfiles, "Recent files" },
        s = { builtin.current_buffer_fuzzy_find, "Search in current buffer" },
        S = { builtin.live_grep, "Live grep" },
        r = { builtin.resume, "Resume last search" },
        p = { builtin.pickers, "Previous search" },
        f = { builtin.builtin, "Pick a picker" },
        b = { builtin.buffers, "Find buffer" },
    },
}
whichkey.register(mappings, opts)

