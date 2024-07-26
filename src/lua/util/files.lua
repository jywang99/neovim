local M = {}

local function isWhitespaceOnly(s)
    return s:match("^%s*$") ~= nil
end

function M.readAllLines(filePath, noBlankLines)
    local file = io.open(filePath, "r")
    if file == nil then
        return nil
    end
    local lines = {}
    for line in file:lines() do
        if noBlankLines and isWhitespaceOnly(line) then
            goto continue
        end
        table.insert(lines, line)
        ::continue::
    end
    file:close()
    return lines
end

function M.truncateFile(filePath)
    local file = io.open(filePath, "w")
    if file == nil then
        return false
    end
    file:close()
    return true
end

return M

