" Use 'tabstop' (8 columns, a full tab) for indent operations in Makefiles.
" It seems odd that the stock plugin doesn't force this on its own.
setlocal shiftwidth=0
let b:undo_indent = 'setlocal shiftwidth<'
