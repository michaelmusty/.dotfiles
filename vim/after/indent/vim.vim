" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
if exists('b:undo_indent')
  let b:undo_indent = b:undo_indent . '|setlocal shiftwidth<'
endif

" If we need to set 'softtabstop' too, do it
if &softtabstop == -1
  setlocal softtabstop=2
  if exists('b:undo_indent')
    let b:undo_indent = b:undo_indent . '|setlocal softtabstop<'
  endif
endif
