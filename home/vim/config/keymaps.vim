" indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Move by display lines with arrow keys
imap <UP> <C-O>gk
imap <DOWN> <C-O>gj
map <UP> gk
map <DOWN> gj

" Resize window in normal mode
nnoremap <leader>+ :resize +4<CR>
nnoremap <leader>- :resize -4<CR>
nnoremap <leader>< :vertical resize -4<CR>
nnoremap <leader>> :vertical resize +4<CR>
