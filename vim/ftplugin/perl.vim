" Run perl -c on file for the current buffer
nnoremap <LocalLeader>pc :write !perl -c<CR>
" Run perlcritic on the file for the current buffer
nnoremap <LocalLeader>pl :write !perlcritic<CR>
" Run the current buffer through perltidy
nnoremap <LocalLeader>pt :%!perltidy<CR>
