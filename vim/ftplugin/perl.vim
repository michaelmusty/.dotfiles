" Run `perl -c` over buffer
nnoremap <buffer> <silent> <LocalLeader>c :write !perl -c<CR>
" Run `perlcritic` over buffer
nnoremap <buffer> <silent> <LocalLeader>l :write !perlcritic<CR>
" Filter buffer through `perltidy`
nnoremap <buffer> <silent> <LocalLeader>t :%!perltidy<CR>
