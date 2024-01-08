function IsNvimTermBufferOpen()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if buf_ft == "nvimterm" and buf_name ~= "" then
            return true
        end
    end
    return false
end

-- Function to check if buffer with filetype=nvimterm is open and return window number
function GetNvimTermWindow()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if buf_ft == "nvimterm" and buf_name ~= "" then
            local wins = vim.fn.getbufinfo(buf)[1].windows
            if #wins > 0 then
                return wins[1]
            end
        end
    end
    return -1
end


local function create_term_if_none()
    if GetNvimTermWindow() > 0 then
        return
    end

    -- create a split for terminal buffer
    vim.cmd('split') -- Create a horizontal split
    vim.cmd('wincmd j') -- Switch to the new split

    -- settings for terminal buffer
    vim.cmd('resize 20') -- 20% height
    vim.cmd('term') -- Open a terminal
    vim.cmd('set filetype=nvimterm')
end

function SwitchToTerm()
    create_term_if_none()
    vim.api.nvim_set_current_win(GetNvimTermWindow())
    vim.api.nvim_feedkeys('i', 'n', true)
end

function KillTerm()
    local termInd = GetNvimTermWindow()
    if termInd < 0 then
        return
    end

    vim.api.nvim_set_current_win(GetNvimTermWindow())
    vim.defer_fn(function()
        local success, _ = pcall(vim.cmd, [[bd!]])
        if not success then
            print("Error executing :bd!")
        end
    end, 50)
end

