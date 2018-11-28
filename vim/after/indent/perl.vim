" The stock Perl indenting is decent, but doesn't include an undo variable;
" this adds one
if !exists('b:undo_indent')
  let b:undo_indent = 'unlet! b:did_indent'
  let b:undo_indent = b:undo_indent . '|setlocal indentexpr< indentkeys<'
  let b:undo_indent = b:undo_indent . '|unlet! b:indent_use_syntax'
  let b:undo_indent = b:undo_indent . '|unlet! b:match_skip'
  let b:undo_indent = b:undo_indent . '|unlet! b:match_words'
endif
