require'barbar'.setup {
  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    NvimTree = {text = 'NvimTree'},
    undotree = {text = 'UndoTree'},
    Outline = {event = 'BufWinLeave', text = 'Outline'},
    -- dapui_watchers = {text = 'Debug'},
    -- dapui_stacks = {text = 'Debug'},
    -- dapui_breakpoints = {text = 'Debug'},
    -- dapui_scopes = {text = 'Debug'},
  },
}

