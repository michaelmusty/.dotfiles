" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_mail_format_flowed') || &compatible
  finish
endif
let b:did_ftplugin_mail_format_flowed = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_mail_format_flowed'
endif

" Use trailing whitespace to denote continued paragraph
setlocal formatoptions+=w
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal formatoptions<'
endif
