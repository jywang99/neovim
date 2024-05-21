local M = {}

-- Function to check if buffer with a specific filetype is open and return window number
function M.getFiletypeWindow(bufFileType)
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if buf_ft == bufFileType and buf_name ~= "" then
            local wins = vim.fn.getbufinfo(buf)[1].windows
            if #wins > 0 then
                return wins[1]
            end
        end
    end
    return -1
end

-- get buffer of a specific filetype
function M.getFiletypeBuffer(bufFileType)
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if buf_ft == bufFileType then
            return buf
        end
    end
    return -1
end

-- get buffer with matching partial filename (including path)
function M.getPartialFilenameBuffer(partial_path)
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        local full_path = vim.fn.expand('%')
        if full_path:find(partial_path, 1, true) then
            return buf
        end
    end
    return -1
end

function M.doAndSwitchBackWindow(func)
    local current_window = vim.fn.win_getid()
    func()
    vim.defer_fn(function()
        vim.api.nvim_set_current_win(current_window)
    end, 100)
end

return M

