" Use two (not four!) spaces for indentation, per convention
call indent#Spaces(2)

" Remove inapplicable defaults from 'indentkeys'; we should only need to undo
" this if the stock plugin didn't already arrange that (before v7.3.539)
setlocal indentkeys-=0#,0{,0},0),:
if !exists('b:undo_indent')
  let b:undo_indent = 'setlocal indentkeys<'
endif
