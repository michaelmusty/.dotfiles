" Only do this when not done yet for this buffer
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Manual indenting
setlocal noautoindent
let b:undo_indent = 'setlocal autoindent<'

" Literal tabs
setlocal noexpandtab
setlocal shiftwidth=0
let b:undo_indent = 'setlocal expandtab< shiftwidth<'
if &softtabstop != -1
  let &l:softtabstop = &l:shiftwidth
  let b:undo_indent .= '|setlocal softtabstop<'
endif
