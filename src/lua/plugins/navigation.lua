local map = vim.keymap.set

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            -- ignore list, ignored in addition to .gitignore
            local ignoreFile = require('util.persist').getPersistPath() .. '/.tsignore'
            local ignoreList, _ = require('util.files').readAllLines(ignoreFile, true)
            if not ignoreList then
                ignoreList = {
                    "node_modules/",
                    ".git/",
                }
            end

            local pickerCfg = {
                hidden = true,
                file_ignore_patterns = ignoreList,
            }
            telescope.setup({
                defaults = {
                    cache_picker = {
                        num_pickers = -1,
                    },
                    path_display = { "truncate" },
                    dynamic_preview_title = true,
                },
                pickers = {
                    find_files = pickerCfg,
                    live_grep = pickerCfg,
                    grep_string = pickerCfg,
                }
            })

            -- string search
            map("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search in current buffer" })
            map("n", "<leader>fS", builtin.live_grep, { desc = "Live grep" })
            map({"n", "v"}, "<leader>fc", builtin.grep_string, { desc = "Search word/selection under cursor" })

            -- files
            map("n", "<leader>fo", builtin.find_files, { desc = "Open file" })
            map("n", "<leader>fh", builtin.oldfiles, { desc = "Recent files" })
            map("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })

            -- meta
            map("n", "<leader>ff", builtin.builtin, { desc = "Pick a picker" })
            map("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
            map("n", "<leader>fp", builtin.pickers, { desc = "Previous searches" })

            local tsOpts = {
                include_declaration = false,
                trim_text = true,
                fname_width = 25,
            }

            map("n", "<leader>ls", function() builtin.lsp_document_symbols(tsOpts) end, { desc = "Symbols in file" })
            map("n", "<leader>lS", function() builtin.lsp_workspace_symbols(tsOpts) end, { desc = "Symbols in workspace" })

        end
    },
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                },
            })

            vim.keymap.set("n", "<M-'>", function() harpoon:list():add() end, { desc = "Add harp" })
            vim.keymap.set("n", "<M-;>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon menu" })

            vim.keymap.set("n", "<M-,>", function() harpoon:list():prev() end, { desc = "Previous harp" })
            vim.keymap.set("n", "<M-.>", function() harpoon:list():next() end, { desc = "Next harp" })
            vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end, { desc = "Go to harp 1" })
            vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end, { desc = "Go to harp 2" })
            vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end, { desc = "Go to harp 3" })
            vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end, { desc = "Go to harp 4" })
            vim.keymap.set("n", "<M-5>", function() harpoon:list():select(5) end, { desc = "Go to harp 5" })
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

