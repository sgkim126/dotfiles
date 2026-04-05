set colorcolumn=+1,+2,+3,+4,+5,+6,+7
set spell spelllang=en_us

highlight link GitCommitSummaryLong Debug
highlight link GitCommitSummaryOverflow Error
highlight link GitCommitSummaryLastDot Error
highlight link GitCommitBodyOverflow Error

" Use matchadd() for guaranteed highlighting that overrides default syntax.
" \%>Nv counts wide-character(e.g. CJK/Emoji) as 2.
call matchadd('GitCommitSummaryLong', '\%1l\%>50v.*', 10)
call matchadd('GitCommitSummaryOverflow', '\%1l\%>72v.*', 11)
call matchadd('GitCommitSummaryLastDot', '\%1l\.$', 12)

" Body (Line > 2) must be within 72 chars, ignoring comments.
" Match starts exactly at the 73rd virtual column.
call matchadd('GitCommitBodyOverflow', '\%>2l\%(^#\)\@!\%>72v.*', 10)
