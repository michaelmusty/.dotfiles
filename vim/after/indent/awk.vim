" Use four spaces for indentation
setlocal expandtab
setlocal shiftwidth=4
let b:undo_ftplugin .= '|setlocal expandtab< shiftwidth<'
if &l:softtabstop != -1
  let &l:softtabstop = &l:shiftwidth
  let b:undo_ftplugin .= '|setlocal softtabstop<'
endif
