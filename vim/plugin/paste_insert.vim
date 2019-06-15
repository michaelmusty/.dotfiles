if exists('loaded_paste_insert')
  finish
endif
let loaded_paste_insert = 1
command! -bar PasteInsert
      \ call paste_insert#()
nnoremap <Plug>PasteInsert
      \ :<C-U>PasteInsert<CR>
