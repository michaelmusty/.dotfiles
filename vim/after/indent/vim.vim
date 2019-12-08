" Remove inapplicable defaults from 'indentkeys'; we should only need to undo
" this if the stock plugin didn't already arrange that (before v7.3.539)
setlocal indentkeys-=0#,0{,0},0),:
if !exists('b:undo_indent')
  let b:undo_indent = 'setlocal indentkeys<'
endif

" Observe VimL conventions for two-space indents
setlocal expandtab
setlocal shiftwidth=2
let b:undo_indent .= '|setlocal expandtab< shiftwidth<'
if &softtabstop != -1
  let &l:softtabstop = &l:shiftwidth
  let b:undo_indent .= '|setlocal softtabstop<'
endif
