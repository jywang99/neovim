local map = vim.keymap.set

return {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require('gitsigns')
            require('gitsigns').setup()

            map("n", "<leader>gl", gitsigns.blame_line, { desc = "Blame" })
            map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
            map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
            map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
            map("n", "<leader>gq", gitsigns.setqflist, { desc = "Show in QF" })

            map("n", "]g", gitsigns.next_hunk, { desc = "Next Git Hunk" })
            map("n", "[g", gitsigns.prev_hunk, { desc = "Previous Git Hunk" })
        end
    },
    {
        'sindrets/diffview.nvim',
        config = function()
            local diffview = require('diffview')
            diffview.setup({
                view = {
                    merge_tool = {
                        -- Config for conflicted files in diff views during a merge or rebase.
                        layout = "diff3_mixed",
                        disable_diagnostics = false,
                    },
                }
            })

            local function diffFileWithRef()
                local ref = vim.fn.input('Ref: ')
                if ref == nil or ref == '' then
                    return
                end
                local cmd = 'DiffviewOpen ' .. ref .. ' -- %'
                vim.cmd(cmd)
            end

            map("n", "<leader>gd", [[:DiffviewOpen<CR>]], { desc = "Open diff view" })
            map("n", "<leader>gD", diffFileWithRef, { desc = "Diff file with ref" })
            map("n", "<leader>gh", [[:DiffviewFileHistory %<CR>]], { desc = "View file history" })

        end
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local neogit = require('neogit')
            neogit.setup()
            map("n", "<leader>gg", neogit.open, { desc = "Open Neogit" })
        end
    },
}

