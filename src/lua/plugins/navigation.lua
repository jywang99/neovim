local map = vim.keymap.set

local function setup_lsp_keymaps()
    local telescope = require('telescope.builtin')

    local tsOpts = {
        include_declaration = false,
        trim_text = true,
        fname_width = 25,
    }

    -- keybindings
    local map = vim.keymap.set
    map("n", "<leader>lf", function() vim.lsp.buf.formatting() end, { desc = "Format file" })
    map("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "Rename" })
    map("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Code actions" })
    map("n", "<leader>ls", function() telescope.lsp_document_symbols(tsOpts) end, { desc = "Symbols in file" })
    map("n", "<leader>lS", function() telescope.lsp_workspace_symbols(tsOpts) end, { desc = "Symbols in workspace" })
    map("n", "<leader>le", function() vim.diagnostic.open_float() end, { desc = "Inline diagnostics" })
    map("n", "<leader>lE", function() telescope.diagnostics() end, { desc = "Workspace diagnostics" })

    map("n", "<C-]>", function() vim.lsp.buf.definition(tsOpts) end, { desc = "Go to definition" })
    map("n", "gr", function() telescope.lsp_references(tsOpts) end, { desc = "References" })
    map("n", "gT", function() telescope.lsp_type_definitions(tsOpts) end, { desc = "Type definitions" })
    map("n", "gi", function() telescope.lsp_implementations(tsOpts) end, { desc = "Implementations" })
end

return {
    -- navigation
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
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

           setup_lsp_keymaps()
        end
    },
    {
        'ThePrimeagen/harpoon',
        config = function()
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
        end
    },
    {
        'stevearc/oil.nvim',
        config = function ()
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
        end
    },
}

