" Use tabs for C
setlocal noexpandtab shiftwidth=0 tabstop=8
if &softtabstop != -1
  let &softtabstop = &shiftwidth
endif
let b:undo_indent .= '|setlocal expandtab< shiftwidth< softtabstop< tabstop<'
