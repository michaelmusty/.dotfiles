" External commands for Perl files
if exists('*shellescape')

  " Run perl -c on file for the current buffer
  nnoremap <LocalLeader>pc :exe "!perl -c " . shellescape(expand("%"))<CR>
  " Run perlcritic on the file for the current buffer
  nnoremap <LocalLeader>pl :exe "!perlcritic " . shellescape(expand("%"))<CR>
  " Run the current buffer through perltidy
  nnoremap <LocalLeader>pt :%!perltidy<CR>

endif
