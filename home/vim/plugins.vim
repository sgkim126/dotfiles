call plug#begin('~/.vim/plugged')

Plug 'gmarik/vundle'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

Plug 'vim-scripts/a.vim'

Plug 'vim-scripts/diffchar.vim'

Plug 'caglartoklu/ftcolor.vim'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

Plug 'tpope/vim-fugitive'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1

Plug 'majutsushi/tagbar'

Plug 'editorconfig/editorconfig-vim'

" python
Plug 'hynek/vim-python-pep8-indent'
Plug 'vim-scripts/pythoncomplete'
Plug 'vim-scripts/python.vim--Vasiliev'
Plug 'jmcantrell/vim-virtualenv'

if executable('ag')
  Plug 'epmatsw/ag.vim'
elseif executable('ack')
  Plug 'mileszs/ack.vim'
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

" tar
Plug 'vim-scripts/tar.vim'

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
Plug 'hail2u/vim-css3-syntax'
Plug 'wavded/vim-stylus'

" React.js
Plug 'mxw/vim-jsx'

" Rust
Plug 'rust-lang/rust.vim'

" Go
Plug 'fatih/vim-go'

" lex, yacc
Plug 'justinmk/vim-syntax-extra'

" vimlint
Plug 'ynkdir/vim-vimlparser' | Plug 'syngan/vim-vimlint'

" Kotlin
Plug 'udalov/kotlin-vim'

" solidity
Plug 'tomlion/vim-solidity'

" elm
Plug 'lambdatoast/elm.vim'

call plug#end()
