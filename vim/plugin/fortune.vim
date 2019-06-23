command! -bar Fortune
      \ call fortune#()
nnoremap <silent> <Plug>(Fortune)
      \ :<C-U>Fortune<CR>
