" Include macros in completion
setlocal complete+=d

" Set include pattern
setlocal include=^\\s*#\\s*include

" Include headers on UNIX
if has('unix')
  setlocal path+=/usr/include
endif

" Undo all of the above
let b:undo_ftplugin .= '|setlocal complete< include< path<'
