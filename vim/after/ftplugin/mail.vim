" Extra configuration for mail messages
if &filetype != 'mail' || &compatible || v:version < 700
  finish
endif

" Add a space to the end of wrapped lines for format-flowed mail
setlocal formatoptions+=w
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal formatoptions<'
