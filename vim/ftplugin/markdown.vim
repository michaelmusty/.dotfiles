" Spellcheck documents by default
if has('syntax')
  setlocal spell

  " Undo
  if !exists('b:undo_ftplugin')
    let b:undo_ftplugin = ''
  endif
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal spell<'
endif
