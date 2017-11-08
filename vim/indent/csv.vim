" Manual indenting and literal tabs for CSVs
setlocal noautoindent
setlocal noexpandtab

" Unload this indent plugin
let b:undo_user_indent
      \ = 'setlocal autoindent< expandtab<'
