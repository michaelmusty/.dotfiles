" Spellcheck documents by default
if has('syntax')
  setlocal spell
endif

" Unload this filetype plugin
let b:undo_user_ftplugin
      \ = 'silent! setlocal spell<'
