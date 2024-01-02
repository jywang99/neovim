require'barbar'.setup {
  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    NvimTree = {text = 'NvimTree'},
    undotree = {text = 'UndoTree'},
    Outline = {event = 'BufWinLeave', text = 'Outline'},
  },
}

