local bufUtils = require('utils.bufferUtils')
require('gitsigns').setup()

function ToggleDiffview()
    if bufUtils.getPartialFilenameBuffer('diffview') < 0 then
        vim.api.nvim_command(':DiffviewOpen')
        return
    end
    vim.api.nvim_command(':DiffviewClose')
end

