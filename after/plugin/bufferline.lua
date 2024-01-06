require("bufferline").setup{
    options = {
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "" then -- stuff like terminal
                return true
            end
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "NvimTree",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "Outline",
                text = "Outline",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "undotree",
                text = "undotree",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "DiffviewFiles",
                text = "DiffviewFiles",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "dapui",
                text = "Debug",
                text_align = "center",
                separator = true,
            },
        },
        numbers = 'ordinal',
        diagnostics = "nvim_lsp",
        sort_by = 'insert_after_current',
    }
}

