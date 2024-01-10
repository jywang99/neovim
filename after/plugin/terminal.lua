local bufUtils = require('lua.jy.bufferUtils')

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

local function termToBottom(buf)
    bufUtils.openBufferInSplit(buf, 'h')
    vim.cmd('resize 20') -- 20% height
    vim.cmd('set filetype=' .. termFt)
end

function CreateTermNew(termStyle)
    -- Check if the termStyle is valid
    if termStyle ~= 'split' and termStyle ~= 'tab' then
        print('Invalid terminal style. Valid: "split" or "tab".')
        return
    end

    local origBuf = vim.api.nvim_get_current_buf()

    -- create a new buffer and run terminal
    local termBuf = vim.api.nvim_create_buf(false, false)
    vim.cmd('term')
    -- split
    if termStyle == 'split' then
        vim.api.nvim_set_current_buf(origBuf)
        termToBottom(termBuf)
    else
        vim.cmd('set filetype=' .. termTabFt)
    end
    vim.api.nvim_feedkeys('i', 'n', true)
end

local function createTerm()
    -- create a split for terminal buffer
    vim.cmd('split') -- Create a horizontal split
    vim.cmd('wincmd j') -- Switch to the new split

    -- settings for terminal buffer
    vim.cmd('resize 20') -- 20% height
    vim.cmd('term') -- Open a terminal
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

