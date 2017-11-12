" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_text_spell') || &compatible
  finish
endif
let b:did_ftplugin_text_spell = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_text_spell'

" Spellcheck documents by default
if has('syntax')
  setlocal spell
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal spell<'
endif
