require('gitsigns').setup()

local dv_open = false
function ToggleDiffview()
    if not dv_open then
        vim.api.nvim_command(':DiffviewOpen')
        dv_open = true
        return
    end
    vim.api.nvim_command(':DiffviewClose')
    dv_open = false
end

