" Extra configuration for 'text' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'text'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Spellcheck documents we're actually editing (not just viewing)
if !&readonly
  setlocal spell
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal spell<'
endif
