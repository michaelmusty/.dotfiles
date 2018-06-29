" sh/comments.vim: Set 'comments' for shell script

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_sh_comments')
  finish
endif

" Flag as loaded
let b:did_ftplugin_sh_comments = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_sh_comments'

" Use trailing whitespace to denote continued paragraph
setlocal comments=:#
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments<'
