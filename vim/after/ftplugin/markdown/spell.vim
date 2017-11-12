" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_markdown_spell') || &compatible
  finish
endif
let b:did_ftplugin_markdown_spell = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_markdown_spell'
endif

" Spellcheck documents by default
if has('syntax')
  setlocal spell
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|setlocal spell<'
  endif
endif
