" Don't show whitespace characters or end-of-line characters visually by
" default, but make \l toggle between them
set nolist
nnoremap <silent>
      \ <Leader>l
      \ :<C-U>setlocal list! list?<CR>

" Clearly show when the start or end of the row does not correspond to the
" start and end of the line
set listchars+=precedes:<,extends:>
