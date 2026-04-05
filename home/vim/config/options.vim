set all&
colorscheme elflord

set wrap
set history=100
set mps+=<:>

set mouse=
set nocompatible
set backspace=indent,eol,start
set startofline

" Search
set hlsearch
set incsearch
set nowrapscan

" UI
set wildmenu
set showcmd
set ruler
set nonumber
set showmatch

" History
set swapfile
set nobackup
set undofile
set undodir=~/.vim/undo

" Windows
set splitright
set splitbelow

" Indentation
set cindent
set smartindent
set breakindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Formatting
set textwidth=119

" Trailing whitespace highlighting
highlight default link TrailingWhitespace Error
match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
