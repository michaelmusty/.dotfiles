" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Undo
if !exists('b:undo_indent')
  let b:undo_indent = ''
endif
let b:undo_indent = b:undo_indent
      \ . '|setlocal shiftwidth< softtabstop< tabstop<'
