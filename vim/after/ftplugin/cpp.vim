" Extra configuration for C++ files
if &filetype !=# 'cpp' || v:version < 700
  finish
endif

" Include macros in completion
setlocal complete+=d
let b:undo_ftplugin .= '|setlocal complete<'

" Set include pattern
setlocal include=^\\s*#\\s*include
let b:undo_ftplugin .= '|setlocal include<'

" Include headers on UNIX
if has('unix')
  setlocal path+=/usr/include
  let b:undo_ftplugin .= '|setlocal path<'
endif
