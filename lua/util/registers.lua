local BASE_DIR_NAME = '/mnt/hgfs/shared/'
local PASTED_FILE = 'clipped.txt'

local M = {}

function M.writeToClipfile(txt)
    local filePath = BASE_DIR_NAME .. PASTED_FILE
    local file = io.open(filePath, "w")
    if file == nil then
        print("Failed to open clipboard file: " .. filePath)
        return
    end
    io.output(file)
    io.write(txt)
    io.close(file)
    print("Saved clipboard to file: " .. filePath)
end

function M.persistRegistTxt(letter)
    local clipTxt = vim.fn.getreg(letter)
    if clipTxt == nil or clipTxt == '' then
        return nil
    end
    M.writeToClipfile(clipTxt)
end

function M.persistDefaultRegistTxt()
    M.persistRegistTxt('"')
end

function M.markAndDo(letter, action)
    local mark = vim.fn.getpos(".")
    vim.fn.setpos("'" .. letter, mark)
    action()
end

function M.promptAndSwap()
    -- prompt for registers
    vim.cmd('echo "Swap register: "')
    local a = vim.fn.nr2char(vim.fn.getchar())
    vim.cmd('echo "with register: "')
    local b = vim.fn.nr2char(vim.fn.getchar())

    -- swap
    local temp = vim.fn.getreg(a)
    vim.fn.setreg(a, vim.fn.getreg(b))
    vim.fn.setreg(b, temp)

    vim.cmd('echo "Swapped."')
end

return M

