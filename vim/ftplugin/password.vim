if exists('b:did_ftplugin')
  finish
endif
setlocal formatoptions=
let b:undo_ftplugin = 'setlocal formatoptions<'
