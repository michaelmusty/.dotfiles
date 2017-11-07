" Spellcheck documents by default
if has('syntax')
  setlocal spell
  let b:undo_user_ftplugin
        \ = 'setlocal spell<'
endif
