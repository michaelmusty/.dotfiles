if exists('loaded_select_old_files') || &compatible || !exists(':oldfiles')
  finish
endif
let loaded_select_old_files = 1
command! -bar -nargs=? SelectOldFiles
      \ call select_old_files#(<f-args>)
nnoremap <Plug>SelectOldFiles
      \ :<C-U>SelectOldFiles<CR>
