" Extra configuration for text files
if &filetype != 'text' || &compatible || v:version < 700
  finish
endif

" Spellcheck documents we're actually editing (not just viewing)
if &modifiable && !&readonly
  setlocal spell
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal spell<'
endif
