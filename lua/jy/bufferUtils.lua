local M = {}

-- Function to check if buffer with filetype=nvimterm is open and return window number
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
    return -1 -- If no buffer with the specified filetype is found
end

-- switch to window if open, otherwise switch to buffer in current window
function M.switchToWinOrBuf(buf)
    local wins = vim.fn.getbufinfo(buf)[1].windows
    if #wins == 0 then
        -- focus terminal buffer
        vim.api.nvim_set_current_buf(buf)
    else
        -- focus terminal split
        vim.api.nvim_set_current_win(wins[1])
    end
    vim.api.nvim_feedkeys('i', 'n', true)
end

-- convert a buffer to split
function M.openBufferInSplit(buffer, splitDirection)
    -- Check if the splitDirection is valid
    if splitDirection ~= 'v' and splitDirection ~= 'h' then
        print('Invalid split direction. Valid: "v" or "h".')
        return
    end

    -- If the buffer doesn't have any window open, open a new split
    local wins = vim.fn.getbufinfo(buffer)[1].windows
    if #wins == 0 then
        if splitDirection == 'v' then
            vim.cmd('vsplit')
        else
            vim.cmd('split')
        end
        -- Switch to the buffer in the newly created split
        vim.api.nvim_set_current_buf(buffer)
    end
end

-- close all windows for buffer
-- FORCE closes all of them
function M.closeBufWins(buffer)
    local wins = vim.fn.getbufinfo(buffer)[1].windows
    for _, win in ipairs(wins) do
        vim.api.nvim_win_close(win, true)
    end
end

return M

