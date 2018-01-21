" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
setlocal softtabstop=2
if exists('b:undo_indent')
  let s:ui = '|setlocal shiftwidth< softtabstop<'
  let b:undo_indent = b:undo_indent . s:ui
endif
