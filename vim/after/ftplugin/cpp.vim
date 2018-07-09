" Extra configuration for C++ files
if &filetype != 'cpp' || &compatible || v:version < 700
  finish
endif

" Set comment formats
setlocal include=^\\s*#\\s*include
setlocal path+=/usr/include
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal include<'
      \ . '|setlocal path<'
