" Replace Vim's stock PHP indent rules. They're very complicated and don't
" work in a predictable way.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Easier just to use 'autoindent'; not perfect, but predictable.
setlocal autoindent
let b:undo_indent = 'setlocal autoindent<'
