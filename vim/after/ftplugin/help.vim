" Extra configuration for Vim help files
if &filetype !=# 'help' || v:version < 700
  finish
endif

" If the buffer is modifiable and writable, we're writing documentation, not
" reading it; don't conceal characters
if &modifiable && !&readonly
  setlocal conceallevel=0
  let b:undo_ftplugin .= '|setlocal conceallevel<'
endif
