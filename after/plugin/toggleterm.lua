local vim = vim

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
})

function ToggleLazyGit()
  lazygit:toggle()
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- map("n", "<leader>/", ":let $VIM_DIR=expand('%:p:h')<CR>:terminal bash --login<CR>cd $VIM_DIR<CR>", opts)

