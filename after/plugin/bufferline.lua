local function isInList(str, list)
    for _, value in ipairs(list) do
        if value == str then
            return true
        end
    end
    return false
end

require("bufferline").setup{
    options = {
        custom_filter = function(buf_number, buf_numbers)
            local filetp = vim.bo[buf_number].filetype
            if isInList(filetp, {'', 'nvimterm'}) then -- stuff like terminal
                return false
            end
            return true
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
        diagnostics = "nvim_lsp",
        sort_by = 'insert_after_current',
    }
}

