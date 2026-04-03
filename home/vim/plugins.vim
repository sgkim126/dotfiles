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
endif


" python
Plug 'vim-scripts/python.vim--Vasiliev'
Plug 'jmcantrell/vim-virtualenv'

if !has('nvim')
  if executable('ag')
    Plug 'epmatsw/ag.vim'
  elseif executable('ack')
    Plug 'mileszs/ack.vim'
  endif
endif

Plug 'kshenoy/vim-signature'

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

" scala
Plug 'derekwyatt/vim-scala'

" c++
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-jp/cpp-vim'
Plug 'phlip9/google-vim_cpp_indent'

" shader language
Plug 'tikhomirov/vim-glsl'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'jason0x43/vim-js-indent'

" TypeScript
Plug 'leafgarland/typescript-vim'

" Web
Plug 'othree/html5.vim'
Plug 'chrisyip/Better-CSS-Syntax-for-Vim'
Plug 'skammer/vim-css-color'
Plug 'wavded/vim-stylus'

" React.js
Plug 'mxw/vim-jsx'

" Rust
Plug 'rust-lang/rust.vim'

" Go
Plug 'fatih/vim-go'

" lex, yacc
Plug 'justinmk/vim-syntax-extra'

" Kotlin
Plug 'udalov/kotlin-vim'

" solidity
Plug 'tomlion/vim-solidity'

" elm
Plug 'lambdatoast/elm.vim'

call plug#end()
