" Preserve the flags for a pattern when repeating a substitution with &; I
" don't really understand why this isn't a default, but there it is
nnoremap <silent>
      \ &
      \ :<C-U>&&<CR>
xnoremap <silent>
      \ &
      \ :<C-U>&&<CR>
