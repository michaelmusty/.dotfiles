" Use trailing whitespace to denote continued paragraph
setlocal formatoptions+=w

" Undo
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal formatoptions<'
