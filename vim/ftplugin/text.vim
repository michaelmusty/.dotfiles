" The 'text' filetype was only added in v7.4.365, so anything older than this
" requires our own filetype plugin to prevent the b:undo_ftplugin extensions
" in after/ftplugin/text.vim from panicking.
if v:version > 704
      \ || v:version == 703 && has('patch365')
  finish
endif
let b:did_ftplugin = 1

" Set comment metacharacters
setlocal comments+=fb:-  " Dashed lists
setlocal comments+=fb:*  " Bulleted lists
setlocal comments+=n:>   " Mail quotes
let b:undo_ftplugin = 'setlocal comments<'
