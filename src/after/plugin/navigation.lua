local tree = require("nvim-tree")
local whichkey = require('which-key')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

tree.setup({
    view = {
        number = true,
        relativenumber = true,
        float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
                relative = "editor",
                width = 50,
                height = 70,
            },
        },
    },
    update_focused_file = {
        enable = true,
    },
    filters = {
        git_ignored = false
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
})

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    e = { function() vim.cmd [[NvimTreeFindFile]] end, "Toggle NvimTree" },
}
whichkey.register(mappings, opts)

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
    },
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- quickfix
local function searchModifiedBufs()
    local buffers = vim.api.nvim_list_bufs()

    local quickfix_list = {}
    for _, bufnr in ipairs(buffers) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local is_modified = vim.api.nvim_buf_get_option(bufnr, 'modified')

        if is_modified then
            table.insert(quickfix_list, {filename = bufname, bufnr = bufnr})
        end
    end

    vim.fn.setqflist(quickfix_list)
    vim.cmd("copen")
end

-- remaps
local map = vim.keymap.set

-- quickfix
map("n", "]q", "<CMD>cnext<CR>zz", { desc = "Forward quickfix" })
map("n", "[q", "<CMD>cprev<CR>zz", { desc = "Backward quickfix" })
map("n", "<leader>co", "<CMD>copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>cp", "<CMD>colder<CR>", { desc = "To older quickfix" })
map("n", "<leader>cn", "<CMD>cnewer<CR>", { desc = "To newer quickfix" })
map("n", "<leader>ce", searchModifiedBufs, { desc = "Show edited buffers" })

-- tabs
map("n", "<C-n>", "gt", { silent = true })
map("n", "<C-p>", "gT", { silent = true })
map("n", "<C-c>", "<CMD>tabclose<CR>", { desc = "Close tab" })

-- windows
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-q>", [[<C-\><C-n><C-w>q]])

-- buffers
map("n", "<BS>", "<CMD>b#<CR>", { desc = "Switch to last buffer" })

