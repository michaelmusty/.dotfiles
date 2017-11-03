" Run `vint` over buffer
" /dev/stdin is not optimal here; it's widely implemented, but not POSIX.
" `vint` does not seem to have another way to parse standard input.
nnoremap <buffer> <silent> <LocalLeader>l
      \ :write !vint -s /dev/stdin<CR>
