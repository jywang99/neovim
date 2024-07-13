local telescope = require('telescope')
local builtin = require('telescope.builtin')
local map = vim.keymap.set

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

map("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search in current buffer" })
map("n", "<leader>fo", builtin.find_files, { desc = "Open file" })
map("n", "<leader>fh", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fS", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
map("n", "<leader>fp", builtin.pickers, { desc = "Previous search" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
map("n", "<leader>ff", builtin.builtin, { desc = "Pick a picker" })

