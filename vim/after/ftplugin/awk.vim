" Extra configuration for AWK scripts
if &filetype !=# 'awk' || v:version < 700
  finish
endif

" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin .= '|setlocal comments< formatoptions'
