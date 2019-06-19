" Use tabs for C
setlocal noexpandtab shiftwidth=0 tabstop=8
if &softtabstop != -1
  let &softtabstop = &shiftwidth
endif
let b:undo_indent .= '|setlocal expandtab< shiftwidth< softtabstop< tabstop<'

" If the path to the file looks like the Vim sources, set 'shiftwidth' to 4
if expand('%:p') =~# '/vim.*src/'
  setlocal shiftwidth=4
endif
