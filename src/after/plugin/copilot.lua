local function acceptWord()
    vim.fn['copilot#Accept']("")
    local bar = vim.fn['copilot#TextQueuedForInsertion']()
    return vim.fn.split(bar,  [[[ *.]\zs]])[1]
end

-- remaps
local map = vim.keymap.set
map('i', '<C-w>', acceptWord, {expr = true, remap = false})

