" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
setlocal softtabstop=2
let b:undo_indent .= '|setlocal shiftwidth< softtabstop<'

" Remove inapplicable defaults from 'indentkeys'
setlocal indentkeys-=0#,0{,0},0),:
let b:undo_indent .= '|setlocal indentkeys<'
