" mail/flowed.vim: Add 'w' flag to 'formatoptions' for mail

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_mail_flowed')
  finish
endif

" Flag as loaded
let b:did_ftplugin_mail_flowed = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_mail_flowed'

" Use trailing whitespace to denote continued paragraph
setlocal formatoptions+=w
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal formatoptions<'
