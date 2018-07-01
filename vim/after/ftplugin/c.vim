" Extra configuration for 'c' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'c'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Set comment formats
setlocal include=^\\s*#\\s*include
setlocal path+=/usr/include
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal include< path<'
