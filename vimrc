" Pathogen
silent! execute pathogen#infect()

" ============================================================================
" CUSTOM CHANGES
" ============================================================================

" Use the , as a leader
let mapleader = ","

" Line numbers (comment out "set relativenumber" if you want normal numbers)
set number

" 80 character line guide
if exists('&colorcolumn')
  set colorcolumn=80
endif

" Use to change colorscheme
silent! colorscheme ir_black
set background=dark

" Highlight trailing whitespace.
match ErrorMsg '\s\+\%#\@<!$'

" ============================================================================
" IMPORTANT OPTIONS
" ============================================================================

" Makes the tabs better
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent

" Ignore compiled files
set wildmenu
set wildignore=*.o,*~,*.pyc,.git\*

" Use mouse
set mouse=a

" Use semicolon instead of colon
nnoremap ; :

" Doesn't store useless backup stuff
set noswapfile
set nobackup
set nowritebackup

" Code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Scroll before you get to the very end
set scrolloff=5
set sidescrolloff=3

" Use F2 as a paste toggle
set pastetoggle=<F2>

" Searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" Automatically refreshes file
set autoread

" History
set undolevels=1000

" Set long lines to be treated as multiple lines when soft wrapped
nnoremap j gj
nnoremap k gk

" Save on losing focus (I don't think this works)
au FocusLost * :wa

" Ensure that we are in modern vim mode, not backwards-compatible vi mode
set nocompatible
set backspace=indent,eol,start

" Useful metrics
set ruler

" More secure encryption
set cryptmethod=blowfish

" Enable filetype detection and syntax hilighting
syntax on
filetype plugin indent on

" Show multicharacter commands as they are being typed
set showcmd

" Syntastic
silent! let g:syntastic_python_checkers = []

" Swap lines
nnoremap <c-up> ddkP
nnoremap <c-down> ddp

