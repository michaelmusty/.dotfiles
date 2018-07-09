" Extra configuration for sed scripts
if &filetype != 'sed' || &compatible || v:version < 700
  finish
endif

" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments<'
      \ . '|setlocal formatoptions<'
