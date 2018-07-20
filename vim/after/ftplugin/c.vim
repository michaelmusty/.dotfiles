" Extra configuration for C files
if &filetype !=# 'c' || v:version < 700
  finish
endif

" Set include pattern
setlocal include=^\\s*#\\s*include
let b:undo_ftplugin .= '|setlocal include<'

" Include headers on UNIX
if has('unix')
  setlocal path+=/usr/include
  let b:undo_ftplugin .= '|setlocal path<'
endif
