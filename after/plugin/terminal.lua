TermWinInd = nil
local function create_term_if_none()
    if TermWinInd then
        return
    end

    vim.cmd('split') -- Create a horizontal split
    vim.cmd('wincmd j') -- Switch to the new split
    TermWinInd = vim.api.nvim_win_get_number(vim.api.nvim_get_current_win())

    vim.cmd('resize 20') -- 20% height
    vim.cmd('term') -- Open a terminal
    vim.api.nvim_feedkeys('i', 'n', true) -- Switch to insert mode
    vim.api.nvim_feedkeys('tmux new-session -A -s nvim-term\n', 'n', true) -- Send 'tmux' command to the terminal
end

local function focus_term()
    local cur_win_ind = vim.api.nvim_win_get_number(vim.api.nvim_get_current_win())
    local distance = TermWinInd - cur_win_ind
    local w = 'w'
    if distance < 0 then
        w = 'W'
        distance = -distance
    end
    for _ = 1, distance, 1 do
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>" .. w, true, false, true), "n", true)
    end
end

function SwitchToTerm()
    create_term_if_none()
    focus_term()
    vim.api.nvim_feedkeys('i', 'n', true)
end

function KillTerm()
    if not TermWinInd then
        return
    end

    focus_term()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)

    vim.defer_fn(function()
        local success, _ = pcall(vim.cmd, [[bd!]])
        if not success then
            print("Error executing :bd!")
        end
    end, 50)

    TermWinInd = nil
end

