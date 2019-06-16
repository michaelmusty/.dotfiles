if exists('loaded_select_old_files')
  finish
endif
let loaded_select_old_files = 1
command! -bar SelectOldFiles
      \ call select_old_files#()
nnoremap <Plug>SelectOldFiles
      \ :<C-U>SelectOldFiles<CR>
