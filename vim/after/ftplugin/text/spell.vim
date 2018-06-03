" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled, or if the 'spell' feature isn't
" available
if exists('b:did_ftplugin_text_spell') || &compatible
  finish
endif
if !has('spell')
  finish
endif
let b:did_ftplugin_text_spell = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_text_spell'
endif

" Spellcheck documents by default
setlocal spell
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal spell<'
endif
