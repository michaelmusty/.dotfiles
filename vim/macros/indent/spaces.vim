" Use spaces for current buffer's indentation (set 'shiftwidth' first)
setlocal expandtab
let b:undo_ftplugin .= '|setlocal expandtab< shiftwidth<'
if &l:softtabstop != -1
  let &l:softtabstop = &l:shiftwidth
  let b:undo_ftplugin .= '|setlocal softtabstop<'
endif
