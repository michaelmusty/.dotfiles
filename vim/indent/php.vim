" Only do this when not done yet for this buffer
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Replace Vim's stock PHP indent rules. They're very complicated and don't
" work in a predictable way. Just use 'autoindent'.
setlocal autoindent
let b:undo_indent = 'setlocal autoindent<'
