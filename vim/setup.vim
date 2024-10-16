""" Options

" whitespace
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set wrap
set autoindent          " auto indenting
filetype indent on      " activates indenting for files

" UI
set cursorline
if !has('nvim')
    " Neovim has its own colorscheme handling
    colorscheme koehler
endif
syntax on               " syntax highlighting
set number
set relativenumber
set cursorline
set termguicolors
set scrolloff=8
set signcolumn=yes
hi Normal guibg=NONE ctermbg=NONE
if !has('nvim')
    hi User1 guifg=#ffdad8  guibg=#880c0e
    hi User2 guifg=#000000  guibg=#F4905C
    hi User3 guifg=#292b00  guibg=#f4f597
    hi User4 guifg=#112605  guibg=#aefe7B
    hi User5 guifg=#051d00  guibg=#7dcc7d
    hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
    hi User8 guifg=#ffffff  guibg=#5b7fbb
    hi User9 guifg=#ffffff  guibg=#810085
    hi User0 guifg=#ffffff  guibg=#094afe
    set statusline=
    set statusline+=%7*\[%n]                                  "buffernr
    set statusline+=%1*\ %<%F\                                "File+path
    set statusline+=%2*\ %y\                                  "FileType
    set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
    set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
    set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
    set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
    set statusline+=%9*\ col:%03c\                            "Colnr
    set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
    set laststatus=2
endif

" copy-paste
set clipboard=unnamed

" search
set ignorecase
set smartcase
set hlsearch

" backups
set noswapfile
set nobackup
if !has('nvim')
    set undodir=~/.vim/undodir
endif
set undofile

" behavior
set isfname+=@-@
set updatetime=50

" terminal
set shell=/bin/bash

""" Mappings
let mapleader = ' '

nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz

" clipboard
vmap <C-c> "+y
vmap <leader>p "_dP

" toggle options
nmap <M-u> :noh<CR>
nmap <leader>n :noh<CR>
nmap <leader>oh :set invhlsearch<CR>
nmap <leader>op :set invpaste<CR>
nmap <leader>on :set invnumber<CR>
nmap <leader>or :set invrelativenumber<CR>

" text manipulation
vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv
imap <C-c> <Esc>O

" tabs
nmap <leader>t :tabnew %<CR>
nmap <leader>z <C-w>T
nmap <C-n> :tabnext<CR>
nmap <C-p> :tabprevious<CR>
nmap <C-c> <CMD>tabclose<CR>

" windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-q> <C-\><C-n><C-w>q

" buffers
nmap <BS> <CMD>b#<CR>


""" Autocmds

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif


""" WSL clipboard
" if filereadable('/etc/wsl.conf')
"     vmap <C-c> :w<Home>silent <End> !clip.exe<CR>
" endif


""" quickfix

nmap <M-c> <CMD>cnext<CR>zz
nmap <M-q> <CMD>cprev<CR>zz
nmap <leader>co <cmd>copen<cr>
nmap <leader>cc <cmd>cclose<cr>
nmap <leader>cp <cmd>colder<cr>
nmap <leader>cn <cmd>cnewer<cr>

augroup QuickFixGroup
  autocmd!
  autocmd FileType qf call SetupQuickFixMappings()
augroup END

function! SetupQuickFixMappings()
  nnoremap <buffer> o <CR><C-w>p
  nmap <buffer> <Tab> jo
  nmap <buffer> <S-Tab> ko
  nmap <buffer> <CR> <CR>:cclose<CR>
endfunction

