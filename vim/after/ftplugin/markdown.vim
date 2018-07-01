" Extra configuration for 'markdown' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'markdown'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Spellcheck documents
setlocal spell
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal spell<'
