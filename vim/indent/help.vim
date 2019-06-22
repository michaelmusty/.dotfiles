" Only do this when not done yet for this buffer
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Literal tabs
setlocal noexpandtab
let b:undo_indent = 'setlocal expandtab<'
if v:version > 703
      \ || v:version == 703 && has('patch629')
  setlocal shiftwidth=0
else
  let &l:shiftwidth = &l:tabstop
endif
let b:undo_indent .= '|setlocal shiftwidth<'
if &softtabstop != -1
  let &l:softtabstop = &l:shiftwidth
  let b:undo_indent .= '|setlocal softtabstop<'
endif
