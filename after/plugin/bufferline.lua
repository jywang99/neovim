local whichkey = require('which-key')

local function isInList(str, list)
    for _, value in ipairs(list) do
        if value == str then
            return true
        end
    end
    return false
end

require("bufferline").setup {
    options = {
        custom_filter = function(buf_number, buf_numbers)
            local filetp = vim.bo[buf_number].filetype
            if isInList(filetp, { 'nvimterm' }) then -- stuff like terminal
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

-- keybindings
local opts = {
    mode = "n",
    prefix = 'g',
}
local mappings = {
    name = "Buffer",
    -- navigation
    h = { '<Cmd>BufferLineCyclePrev<CR>', "Previous tab" },
    l = { '<Cmd>BufferLineCycleNext<CR>', "Next tab" },
    ["p"] = { '<Cmd>BufferLinePick<CR>', "Magic buffer-picking mode" },
    ["1"] = { '<Cmd>BufferLineGoToBuffer 1<CR>', "Goto buffer in position 1" },
    ["2"] = { '<Cmd>BufferLineGoToBuffer 2<CR>', "Goto buffer in position 2" },
    ["3"] = { '<Cmd>BufferLineGoToBuffer 3<CR>', "Goto buffer in position 3" },
    ["4"] = { '<Cmd>BufferLineGoToBuffer 4<CR>', "Goto buffer in position 4" },
    ["5"] = { '<Cmd>BufferLineGoToBuffer 5<CR>', "Goto buffer in position 5" },
    ["6"] = { '<Cmd>BufferLineGoToBuffer 6<CR>', "Goto buffer in position 6" },
    ["7"] = { '<Cmd>BufferLineGoToBuffer 7<CR>', "Goto buffer in position 7" },
    ["8"] = { '<Cmd>BufferLineGoToBuffer 8<CR>', "Goto buffer in position 8" },
    ["9"] = { '<Cmd>BufferLineGoToBuffer 9<CR>', "Goto buffer in position 9" },
    -- close buffers
    ["w"] = { '<Cmd>:bp<bar>sp<bar>bn<bar>bd<CR><CR>', "Close current" },
    k = {
        name = 'batch close buffers',
        o = { '<Cmd>BufferLineCloseOthers<CR>', "Close all but current buffer" },
        h = { '<Cmd>BufferLineCloseLeft<CR>', "Close buffers to the left" },
        l = { '<Cmd>BufferLineCloseRight<CR>', "Close buffers to the right" },
        p = { '<Cmd>BufferLinePickClose<CR>', "Pick a buffer to close" },
    },
    -- buffer ordering
    ["<"] = { '<Cmd>BufferLineMovePrev<CR>', "Move buffer to left" },
    [">"] = { '<Cmd>BufferLineMoveNext<CR>', "Move buffer to left" },
    o = {
        ["d"] = { '<Cmd>BufferLineSortByDirectory<CR>', "Sort automatically by directory" },
        ["e"] = { '<Cmd>BufferLineSortByExtension<CR>', "Sort automatically by extension" },
    },
    -- lsp
    d = { '<Cmd>lua vim.lsp.buf.definition()<CR>', "Go to definition" },
    D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', "Go to declaration" },
}
whichkey.register(mappings, opts)

