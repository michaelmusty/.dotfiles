" Use tabs for indent in Git config files, rather than fighting with the
" frontend tool
setlocal noexpandtab
setlocal softtabstop=0
let &shiftwidth = &tabstop
let b:undo_indent .= '|setlocal expandtab< softtabstop< shiftwidth<'
