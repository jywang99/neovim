local M = {}

function M.inputNumber(prompt)
    local idx = vim.fn.input(prompt)
    local numIdx = tonumber(idx)
    if not numIdx then
        print('Invalid argument, number expected!')
        return
    end
    return numIdx
end

return M

