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
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- quickfix

local prevSearch = ""
local prevFilePtn = "**/*"
local function promptGlobalSearch()
    -- prompt for search string
    local kw = vim.fn.input('Search for string (default: ' .. prevSearch .. '): ')
    if kw == "" then
        kw = prevSearch
    end
    if kw == "" then
        print("No search string provided!")
        return
    end
    prevSearch = kw

    -- prompt for file pattern
    local filePtn = vim.fn.input('File pattern (default: ' .. prevFilePtn .. '): ')
    if filePtn == "" then
        filePtn = prevFilePtn
    end
    prevFilePtn = filePtn

    -- do it
    vim.cmd("vim /" .. kw .. "/ " .. filePtn .. " | copen")
end

local function writeCmdOutputToNewBuf(cmd)
    local command_output = vim.api.nvim_command_output(cmd)
    vim.api.nvim_command("enew")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(command_output, '\n'))
end

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


vim.keymap.set("n", "]q", "<CMD>cnext<CR>zz", { desc = "Forward quickfix" })
vim.keymap.set("n", "[q", "<CMD>cprev<CR>zz", { desc = "Backward quickfix" })
vim.keymap.set("n", "<leader>sg", promptGlobalSearch, { desc = "Global search" })
vim.keymap.set("n", "<leader>sh", function() writeCmdOutputToNewBuf("chistory") end, { desc = "Copy search history to register h" })
vim.keymap.set("n", "<leader>co", "<CMD>copen<CR>", { desc = "Open quickfix" })
vim.keymap.set("n", "<leader>cp", "<CMD>colder<CR>", { desc = "To older quickfix" })
vim.keymap.set("n", "<leader>cn", "<CMD>cnewer<CR>", { desc = "To newer quickfix" })
vim.keymap.set("n", "<leader>ce", searchModifiedBufs, { desc = "Show edited buffers" })

