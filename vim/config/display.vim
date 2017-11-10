" Don't show the Vim startup message, I have registered Vim and donated to
" Uganda
set shortmess+=I

" Don't show whitespace characters or end-of-line characters visually by
" default, but make \l toggle between them
set nolist
nnoremap <silent>
      \ <Leader>l
      \ :<C-U>setlocal list! list?<CR>

" Don't show line numbers by default, but \n toggles them
set nonumber
nnoremap <silent>
      \ <Leader>n
      \ :<C-U>setlocal number! number?<CR>
