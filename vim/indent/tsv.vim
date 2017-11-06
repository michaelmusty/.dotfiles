" Manual indenting and literal tabs for TSVs
setlocal noautoindent
setlocal noexpandtab

" Undo
if !exists('b:undo_indent')
  let b:undo_indent = ''
endif
let b:undo_indent = b:undo_indent
      \ . '|setlocal autoindent< expandtab<'
