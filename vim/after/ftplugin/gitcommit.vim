" Extra configuration for 'gitcommit' filetypes
if &compatible || v:version < 700 || exists('b:did_ftplugin_after')
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
setlocal formatoptions+=or
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments< formatoptions<'
