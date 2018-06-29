" Extra configuration for 'cpp' filetypes
if &compatible || v:version < 700 || exists('b:did_ftplugin_cpp')
  finish
endif
let b:did_ftplugin_cpp = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_cpp'

" Set comment formats
setlocal include=^\\s*#\\s*include
setlocal path+=/usr/include
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal include< path<'
