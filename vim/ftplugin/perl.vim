" Run `perl -c` over buffer
nnoremap <buffer> <silent>
      \ <LocalLeader>c
      \ :<C-U>write !perl -c<CR>

" Run `perlcritic` over buffer
nnoremap <buffer> <silent>
      \ <LocalLeader>l
      \ :<C-U>write !perlcritic<CR>

" Filter buffer through `perltidy`
nnoremap <buffer> <silent>
      \ <LocalLeader>t
      \ :<C-U>%!perltidy<CR>

" Unload this filetype plugin
let l:undo_user_ftplugin
      \ = 'silent! nunmap <LocalLeader>c'
      \ . '|silent! nunmap <LocalLeader>l'
      \ . '|silent! nunmap <LocalLeader>t'
