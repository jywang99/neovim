local ws = require("jy.workspace")
require("jy.remap")
require("jy.set")

vim.cmd("source ~/.config/nvim/vim/setup.vim")

-- Load workspace if no file is specified
local args = vim.fn.argv()
local last = args[#args]
if not last or vim.fn.filewritable(last) == 0 then
    ws.loadWorkspace()

    vim.api.nvim_create_autocmd('VimLeavePre', {
        desc = 'Save workspace',
        callback = ws.saveWorkspace,
    })
end

