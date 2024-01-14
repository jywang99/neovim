local telescope = require('telescope')

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

