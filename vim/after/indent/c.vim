" Use hard tabs for C
setlocal noexpandtab
setlocal shiftwidth=0
let b:undo_indent .= '|setlocal expandtab< shiftwidth<'
if &softtabstop != -1
  let &softtabstop = &shiftwidth
  let b:undo_indent .= '|setlocal softtabstop<'
endif

" If the path to the file looks like the Vim sources, set 'shiftwidth' to 4
if expand('%:p') =~# '/vim.*src/'
  setlocal shiftwidth=4
endif
