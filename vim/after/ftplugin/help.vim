" Extra configuration for 'help' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'help'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" If the buffer is modifiable and writable, we're writing documentation, not
" reading it; don't conceal characters
if &modifiable && !&readonly
  setlocal conceallevel=0
  let b:undo_ftplugin = b:undo_ftplugin
	\ . '|setlocal conceallevel'
endif
