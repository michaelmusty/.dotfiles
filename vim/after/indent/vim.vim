" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
if v:version > 703 || v:version == 703 && has('patch693')
  setlocal softtabstop=-1
else
  setlocal softtabstop=2
endif

" Commands to undo the above
if exists('b:undo_indent')
  let b:undo_indent = b:undo_indent . '|setlocal shiftwidth<'
  let b:undo_indent = b:undo_indent . '|setlocal softtabstop<'
endif
