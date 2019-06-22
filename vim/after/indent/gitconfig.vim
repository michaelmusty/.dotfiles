" Use tabs for indent in Git config files, rather than fighting with the
" frontend tool
setlocal noexpandtab
setlocal shiftwidth=0
let b:undo_indent .= '|setlocal expandtab< shiftwidth<'
if &softtabstop != -1
  let &softtabstop = &shiftwidth
  let b:undo_indent .= '|setlocal softtabstop<'
endif
