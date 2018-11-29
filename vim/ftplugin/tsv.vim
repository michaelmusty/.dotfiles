" Only do this when not yet done for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" No autoformatting, literal tabs
setlocal noautoindent
setlocal noexpandtab
setlocal formatoptions=
let b:undo_ftplugin = 'setlocal autoindent< expandtab< formatoptions<'
