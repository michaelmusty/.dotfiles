" Extra configuration for mail messages
if &filetype !=# 'mail' || v:version < 700
  finish
endif

" We will almost always want to start editing after the headers, so move to
" the first entirely blank line, if something hasn't already moved us from the
" start of the file
if line('.') == 1 && col('.') == 1
  call search('^$', 'c')
endif

" Add a space to the end of wrapped lines for format-flowed mail
setlocal formatoptions+=w
let b:undo_ftplugin .= '|setlocal formatoptions<'
