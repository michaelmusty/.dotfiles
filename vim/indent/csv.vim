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
setlocal softtabstop=0
let &shiftwidth = &tabstop
let b:undo_indent = 'setlocal expandtab< softtabstop< shiftwidth<'
