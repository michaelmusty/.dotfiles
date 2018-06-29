" awk/comments.vim: Set 'comments' and supporting 'formatoptions' for AWK

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_awk_comments')
  finish
endif

" Flag as loaded
let b:did_ftplugin_awk_comments = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_awk_comments'

" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments< formatoptions<'
