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

function M.isBufferInAnyTab(buffer)
    local tabpages = vim.api.nvim_list_tabpages()
    for _, tabpage in ipairs(tabpages) do
        local windows = vim.api.nvim_tabpage_list_wins(tabpage)
        for _, win in ipairs(windows) do
            if vim.api.nvim_win_get_buf(win) == buffer then
                return true
            end
        end
    end
    return false
end

function M.openBufInNewTab(buf)
    if M.isBufferInAnyTab(buf) then
        return
    end

    local current_tab = vim.api.nvim_get_current_tabpage()
    vim.cmd('tabnew')
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_set_current_tabpage(current_tab)
end

local function find_terminal_buffers()
  local terminal_buffers = {}

  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if vim.api.nvim_buf_get_option(buf.bufnr, "buftype") == "terminal" then
      table.insert(terminal_buffers, {
        bufnr = buf.bufnr,
        name = vim.fn.bufname(buf.bufnr),
      })
    end
  end

  return terminal_buffers
end

function M.list_terminals_in_quickfix()
  local terminal_buffers = find_terminal_buffers()

  local qf_list = {}
  for _, buf in ipairs(terminal_buffers) do
    table.insert(qf_list, {
      bufnr = buf.bufnr,
      text = buf.name ~= '' and buf.name or '[No Name]',
    })
  end

  -- Set the quickfix list and open it
  vim.fn.setqflist(qf_list, 'r')
  vim.cmd('copen')
end

return M

