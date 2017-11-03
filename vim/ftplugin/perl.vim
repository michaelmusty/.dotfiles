" Run `perl -c` over buffer
nnoremap <LocalLeader>pc :write !perl -c<CR>
" Run `perlcritic` over buffer
nnoremap <LocalLeader>pl :write !perlcritic<CR>
" Filter buffer through `perltidy`
nnoremap <LocalLeader>pt :%!perltidy<CR>
