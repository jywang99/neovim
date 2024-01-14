local whichkey = require('which-key')
local sidebar = require('util.sidebar')
local buffers = require('util.buffers')

local opts = {
    relative_width = true,
    width = 15,
    show_numbers = true,
    show_relative_numbers = true,
    wrap = true,
    symbols = {
        File = { icon = "Ƒ", hl = "@text.uri" },
        Module = { icon = "M", hl = "@namespace" },
        Namespace = { icon = "N", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "f", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "[", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "E", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "c", hl = "@function" },
        Fragment = { icon = ";", hl = "@constant" },
    },
}
require("symbols-outline").setup(opts)

local function toggleOutline()
    if buffers.getFiletypeBuffer('Outline') > 0 then
        pcall(vim.cmd, 'SymbolsOutlineClose')
        return
    end
    sidebar.closeRightBufs()
    buffers.doAndSwitchBackWindow(function()
        vim.cmd [[SymbolsOutlineOpen]]
    end)
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>',
}
local mappings = {
    o = { toggleOutline, "Toggle SymbolsOutline" },
}
whichkey.register(mappings, opts)

