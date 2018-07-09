" Extra configuration for sed scripts
if &filetype !=# 'sed' || v:version < 700
  finish
endif

" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'
