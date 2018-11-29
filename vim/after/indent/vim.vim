" Remove inapplicable defaults from 'indentkeys'
" Should only need to undo this if the stock plugin didn't
setlocal indentkeys-=0#,0{,0},0),:
if !exists('b:undo_indent')
  let b:undo_indent = 'setlocal indentkeys<'
endif

" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
setlocal softtabstop=2
let b:undo_indent .= '|setlocal shiftwidth< softtabstop<'
