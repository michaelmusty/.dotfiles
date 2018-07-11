" Extra configuration for C files
if &filetype !=# 'c' || v:version < 700
  finish
endif

" Set comment formats
setlocal include=^\\s*#\\s*include
setlocal path+=/usr/include
let b:undo_ftplugin .= '|setlocal include< path<'
