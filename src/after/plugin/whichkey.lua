local registers = require('util.registers')
local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
    return
end

which_key.setup({})

local function openInNewTab()
    vim.cmd [[tabnew %]]
    vim.opt.number = true
end

local opts = {
    mode = "n",
}
local mappings = {
    -- main menu
    ["<leader>"] = {
        -- buffers
        b = {
            name = 'Buffers',
            k = { [[:%bd|e#<CR>]], 'Close all other buffers' },
        },
        z = { openInNewTab, 'Open current buffer in new tab' },

        -- persistence
        s = {
            name = 'Persistence',
            p = { registers.persistDefaultRegistTxt, 'Persist default register' },
        },
        n = { [[:noh<CR>]], 'Clear search highlights' },
   },
   -- tabs
   ['<C-t>'] = { [[:tabnew<CR>]], 'New tab' },
   ['<C-x>'] = { [[:tabclose<CR>]], 'Close tab' },
}
which_key.register(mappings, opts)
