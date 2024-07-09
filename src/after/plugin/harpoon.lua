local harpoon = require("harpoon")
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

harpoon.setup()

-- keybindings
vim.keymap.set("n", "<M-;>", ui.toggle_quick_menu, { desc = "Open harpoon menu" })
vim.keymap.set("n", "<M-'>", mark.add_file, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<M-,>", ui.nav_prev, { desc = "Prev harp" })
vim.keymap.set("n", "<M-.>", ui.nav_next, { desc = "Next harp" })
vim.keymap.set("n", "<M-1>", function() ui.nav_file(1) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-2>", function() ui.nav_file(2) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-3>", function() ui.nav_file(3) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-4>", function() ui.nav_file(4) end, { desc = "Go to harp 1" })
vim.keymap.set("n", "<M-5>", function() ui.nav_file(5) end, { desc = "Go to harp 1" })

