" Extra configuration for 'gitcommit' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'gitcommit'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Make angle brackets behave like mail quotes
setlocal comments+=n:>
setlocal formatoptions+=cor
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments< formatoptions<'
