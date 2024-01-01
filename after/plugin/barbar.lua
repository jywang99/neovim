require'barbar'.setup {
  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    NvimTree = {text = 'undotree'},
    undotree = {text = 'undotree'},
    Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
  },
}

