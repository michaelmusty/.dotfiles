" Extra configuration for C++ files
if &filetype !=# 'cpp' || v:version < 700
  finish
endif

" Set comment formats
setlocal include=^\\s*#\\s*include
let b:undo_ftplugin .= '|setlocal include<'

" Include headers on UNIX
if has('unix')
  setlocal path+=/usr/include
  let b:undo_ftplugin .= '|setlocal path<'
endif
