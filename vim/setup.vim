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

" movement
nnoremap <silent> k :<C-U>execute 'normal!' (v:count > 1 ? "m'" . v:count : '') . 'k'<CR>
nnoremap <silent> j :<C-U>execute 'normal!' (v:count > 1 ? "m'" . v:count : '') . 'j'<CR>

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
nmap <leader>tt :tabnew %<CR>
nmap <leader>z <C-w>T
nmap <C-p> :tabprevious<CR>
nmap <C-n> :tabnext<CR>
nmap <leader>tp :tabm -1<CR>
nmap <leader>tn :tabm +1<CR>
nmap <C-c> <CMD>tabclose<CR>

" windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-q> :q<CR>

" buffers
nmap <BS> <CMD>b#<CR>

" diff
nmap ]c ]czz
nmap [c [czz

" marks
nmap <leader>md :delmarks a-zA-Z0-9<CR>


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

""" quickfix

nmap <M-c> <CMD>cnext<CR>zz
nmap <M-x> <CMD>cprev<CR>zz
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

