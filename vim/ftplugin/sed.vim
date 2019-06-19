" Only do this when not yet done for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin = 'setlocal comments< formatoptions<'

" Fold based on indent level
setlocal foldmethod=indent
let b:undo_ftplugin .= '|setlocal foldmethod<'
