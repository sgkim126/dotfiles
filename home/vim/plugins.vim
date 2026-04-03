call plug#begin('~/.vim/plugged')

if !has('nvim')
  " LSP Support for Vim
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif

Plug 'vim-scripts/diffchar.vim'

Plug 'tpope/vim-fugitive'

if !has('nvim')
  Plug 'nathanaelkane/vim-indent-guides'
  let g:indent_guides_enable_on_vim_startup = 1

  Plug 'editorconfig/editorconfig-vim'

  if executable('ag')
    Plug 'epmatsw/ag.vim'
  elseif executable('ack')
    Plug 'mileszs/ack.vim'
  endif
endif

Plug 'kshenoy/vim-signature'

" Python
if !has('nvim')
  Plug 'vim-python/python-syntax'
  let g:python_highlight_all = 1
  Plug 'jmcantrell/vim-virtualenv'
endif

" Markdown
Plug 'godlygeek/tabular'
if !has('nvim')
  Plug 'plasticboy/vim-markdown'
  let g:vim_markdown_folding_disabled=1
endif

" Scala
if !has('nvim')
  Plug 'derekwyatt/vim-scala'
endif

" C++
if !has('nvim')
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'vim-jp/cpp-vim'
  Plug 'phlip9/google-vim_cpp_indent'
endif

" Shading language
if !has('nvim')
  Plug 'tikhomirov/vim-glsl'
endif

" JavaScript/TypeScript/React
if !has('nvim')
  Plug 'pangloss/vim-javascript'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'jason0x43/vim-js-indent'
  Plug 'leafgarland/typescript-vim'
  Plug 'MaxMEllon/vim-jsx-pretty'
endif

" Web
if !has('nvim')
  Plug 'othree/html5.vim'
  Plug 'chrisyip/Better-CSS-Syntax-for-Vim'
  Plug 'wavded/vim-stylus'
endif
Plug 'ap/vim-css-color'

" Rust
if !has('nvim')
  Plug 'rust-lang/rust.vim'
endif

" Go
if !has('nvim')
  Plug 'fatih/vim-go'
endif

" Lex & Yacc
if !has('nvim')
  Plug 'justinmk/vim-syntax-extra'
endif

" Kotlin
if !has('nvim')
  Plug 'udalov/kotlin-vim'
endif

" Solidity
if !has('nvim')
  Plug 'tomlion/vim-solidity'
endif

" Elm
if !has('nvim')
  Plug 'lambdatoast/elm.vim'
endif

call plug#end()
