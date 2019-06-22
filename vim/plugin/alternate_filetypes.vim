command -bar AlternateFileType
      \ call alternate_filetypes#() | set filetype?
nnoremap <silent> <Plug>(AlternateFileType)
      \ :<C-U>AlternateFileType<CR>
