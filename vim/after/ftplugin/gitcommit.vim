" Extra configuration for Git commit messages
if &filetype !=# 'gitcommit' || v:version < 700
  finish
endif

" Make angle brackets behave like mail quotes
setlocal comments+=n:>
setlocal formatoptions+=coqr
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'
