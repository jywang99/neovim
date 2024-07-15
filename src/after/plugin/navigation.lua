local map = vim.keymap.set

-- oil

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("oil").setup({
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.select_tab",
        ["<C-i>"] = "actions.preview",
        ["<C-q>"] = "actions.close",
        ["<R>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["="] = "actions.open_cwd",
        -- ["`"] = "actions.cd",
        -- ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        -- ["g\\"] = "actions.toggle_trash",
        ['<leader>yp'] = {
            desc = 'Copy filepath to system clipboard',
            callback = function ()
                require('oil.actions').copy_entry_path.callback()
                vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
            end,
        },
    },
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },
})

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- harpoon

local harpoon = require("harpoon")
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

harpoon.setup()
vim.keymap.set("n", "<M-;>", ui.toggle_quick_menu, { desc = "Open harpoon menu" })
vim.keymap.set("n", "<M-'>", mark.add_file, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<M-,>", ui.nav_prev, { desc = "Prev harp" })
vim.keymap.set("n", "<M-.>", ui.nav_next, { desc = "Next harp" })
vim.keymap.set("n", "<M-1>", function() ui.nav_file(1) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-2>", function() ui.nav_file(2) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-3>", function() ui.nav_file(3) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-4>", function() ui.nav_file(4) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-5>", function() ui.nav_file(5) end, { desc = "Go to harp 1" })

-- telescope

local telescope = require('telescope')
local builtin = require('telescope.builtin')

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

