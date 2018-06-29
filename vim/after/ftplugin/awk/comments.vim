" awk/comments.vim: Set 'comments' for AWK

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_awk_format')
  finish
endif

" Flag as loaded
let b:did_ftplugin_awk_format = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_awk_format'

" Use trailing whitespace to denote continued paragraph
setlocal comments=:#
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments< formatoptions<'
