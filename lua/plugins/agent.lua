local map = vim.keymap.set
local fn = vim.fn

return {
    {
        'github/copilot.vim',

        map("n", "<leader>ai", ":Copilot enable<CR>", { desc = "Enable Copilot" });
        map("n", "<leader>an", ":Copilot disable<CR>", { desc = "Disable Copilot" });

        config = function()
            local function acceptWord()
                fn['copilot#Accept']("")
                local bar = fn['copilot#TextQueuedForInsertion']()
                return fn.split(bar,  [[[ *.]\zs]])[1]
            end
            map('i', '<C-f>', acceptWord, {expr = true, remap = false})
        end
    },
    {
        "yetone/avante.nvim",
        build = fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
        event = "VeryLazy",
        version = false,
        opts = {
            instructions_file = "avante.md",
            provider = "copilot",
            behaviour = {
                auto_approve_tool_permissions = false,
            },
        mappings = {
            submit = {
                insert = "<C-j>",
            },
            sidebar = {
                close_from_input = {
                    normal = "<Esc>",
                },
            },
        },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "zbirenbaum/copilot.lua",
        },
    }
}

