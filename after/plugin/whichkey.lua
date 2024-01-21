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
        -- window switcher
        w = { require('nvim-window').pick, 'Jump to window' },
        -- buffers
        b = {
            name = 'Buffers',
            k = { [[:%bd|e#<CR>]], 'Close all other buffers' },
        },
        z = { openInNewTab, 'Open current buffer in new tab' },
    },
    -- tabs
    ['<C-t>'] = { [[:tabnew<CR>]], 'New tab' },
    ['<C-x>'] = { [[:tabclose<CR>]], 'Close tab' },
    -- splits
    ['<C-w>'] = {
        g = { [[:resize 20<CR>]], 'Goblin mode' },
    },
}
which_key.register(mappings, opts)
