" Extra configuration for 'mail' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'mail'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Add a space to the end of wrapped lines for format-flowed mail
setlocal formatoptions+=w
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal formatoptions<'
