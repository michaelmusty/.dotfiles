" The stock AWK indenting is decent, but doesn't include an undo variable;
" this adds one, clearing away the sole global function too.
if !exists('b:undo_indent')
  let b:undo_indent = 'unlet! b:did_indent'
  let b:undo_indent = b:undo_indent . '|setlocal indentexpr< indentkeys<'
  let b:undo_indent = b:undo_indent . '|delfunction! GetAwkIndent'
endif
