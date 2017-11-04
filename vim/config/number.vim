" Don't show line numbers by default, but \n toggles them
set nonumber
nnoremap <silent>
      \ <Leader>n
      \ :<C-U>setlocal number! number?<CR>
