local bufUtils = require('util.buffers')
local whichkey = require('which-key')

local termFt = 'nvimterm'
local termTabFt = 'nvimterm_tab'

local function findTermBuf()
    local termBuf = -1
    -- window mode
    termBuf = bufUtils.getFiletypeBuffer(termFt)
    if termBuf < 0 then
        -- tab mode
        termBuf = bufUtils.getFiletypeBuffer(termTabFt)
    end
    return termBuf
end

local function createTerm()
    -- create a split for terminal buffer
    vim.cmd('split')    -- Create a horizontal split
    vim.cmd('wincmd j') -- Switch to the new split

    -- settings for terminal buffer
    vim.cmd('resize 20') -- 20% height
    vim.cmd('term')      -- Open a terminal
    vim.cmd('set filetype=' .. termFt)
    return vim.api.nvim_get_current_buf()
end

function CreateAndSwitchToTerm()
    local buf = findTermBuf()
    -- create terminal only if it doesn't exist yet
    if buf < 0 then
        buf = createTerm()
    end
    bufUtils.switchToWinOrBuf(buf)
end

function CloseTerm(kill)
    -- do nothing if terminal not open
    local termBuf = findTermBuf()
    if termBuf < 0 then
        return
    end

    bufUtils.closeBufWins(termBuf)
    if kill then
        vim.api.nvim_buf_delete(termBuf, { force = true })
    end
end

function TermToTab()
    local buf = findTermBuf()
    if buf < 0 then
        return
    end
    local currentFt = vim.api.nvim_buf_get_option(buf, 'filetype')
    if currentFt == termTabFt then
        return
    end
    bufUtils.closeBufWins(buf)
    vim.api.nvim_buf_call(buf, function()
        vim.cmd('set filetype=' .. termTabFt)
    end)
end

function TermToSplit()
    local buf = findTermBuf()
    if buf < 0 then
        return
    end
    local currentFt = vim.api.nvim_buf_get_option(buf, 'filetype')
    if currentFt == termFt then
        return
    end
    bufUtils.openBufferInSplit(buf, 'h')
    vim.api.nvim_buf_call(buf, function()
        vim.cmd('set filetype=' .. termFt)
    end)
    local win = vim.fn.getbufinfo(buf)[1].windows[1]
    vim.api.nvim_win_call(win, function()
        vim.cmd('resize 20') -- 20% height
    end)
end

-- keybindings
local opts = {
    mode = "n",
    prefix = '<leader>t',
}
local mappings = {
    t = { CreateAndSwitchToTerm, 'Open terminal' },
    x = { function() CloseTerm(true) end, 'Kill terminal' },
    s = { TermToSplit, 'Put terminal to split' },
    b = { TermToTab, 'Put terminal to tab' },
}
whichkey.register(mappings, opts)

