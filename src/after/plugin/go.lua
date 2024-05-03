local whichkey = require('which-key')

require('dap-go').setup {
    dap_configurations = {
        {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
        },
    },
    -- delve configurations
    delve = {
        args = {},
        -- the build flags that are passed to delve.
        -- defaults to empty string, but can be used to provide flags
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        build_flags = "",
    },
}

require("gopher").setup {
    commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "~/go/bin/gotests", -- also you can set custom command path
        impl = "impl",
        iferr = "iferr",
    },
}

-- keybindings
local function goTidy()
    vim.cmd [[GoMod tidy]]
    vim.cmd [[LspRestart]]
end

local function organizeImports()
    vim.lsp.buf.code_action()
    vim.cmd [[1]]
end

local function setKeymaps()
    local opts = {
        mode = "n",
        prefix = '<leader>l',
    }
    local mappings = {
        name = "LSP",
        -- editing
        R = { goTidy, "Go Tidy" },
        i = { organizeImports, "Organize imports" },
    }
    whichkey.register(mappings, opts)
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go' },
    desc = 'Keybindings for Go',
    callback = function()
        setKeymaps()
    end,
})
