if has('nvim')
    finish
endif

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_preview_float = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_document_highlight_enabled = 1

function! s:on_lsp_buffer_enabled() abort
    " ctags 스타일
    setlocal tagfunc=lsp#tagfunc

    " 자동 완성 옵션
    setlocal completeopt=menuone,noinsert,noselect,preview

    nmap <buffer> <leader>K <plug>(lsp-hover)

    nmap <buffer> <leader>gd <plug>(lsp-definition)
    nmap <buffer> <leader>gD <plug>(lsp-declaration)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)

    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>ca <plug>(lsp-code-action)
    nmap <buffer> <leader>f <plug>(lsp-document-format)

    " 탭/엔터 완성 매핑
    " pumvisible = 팝업창이 떠있을 때
    inoremap <expr> <buffer> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <buffer> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <buffer> <cr>    pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
endfunction

augroup lsp_install
    au!
    " LSP가 활성화된 버퍼에서만 단축키 적용
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_settings = {
\  'clangd': {'allowlist': ['c', 'cpp', 'objc', 'objcpp']},
\  'gopls': {'allowlist': ['go']},
\  'pyright-langserver': {'allowlist': ['python']},
\  'rust-analyzer': {'allowlist': ['rust']},
\  'typescript-language-server': {'allowlist': ['javascript', 'typescript', 'javascriptreact', 'typescriptreact']},
\  'html-languageserver': {'allowlist': ['html']},
\  'marksman': {'allowlist': ['markdown']},
\  'jdtls': {'allowlist': ['java']},
\  'kotlin-language-server': {'allowlist': ['kotlin']},
\  'metals': {'allowlist': ['scala']},
\}
