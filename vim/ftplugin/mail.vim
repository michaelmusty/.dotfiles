" Use trailing whitespace to denote continued paragraph
setlocal formatoptions+=w

" Unload this filetype plugin
let b:undo_user_ftplugin
      \ = 'setlocal formatoptions<'
