" Clear away the flag we set to indent after paragraphs
unlet html_indent_inctags

" Don't re-indent lines on right-angle-bracket or enter
setlocal indentkeys-=<>>,<Return>
let b:undo_ftplugin .= '|setlocal indentkeys<'

" Use four spaces for indentation
setlocal expandtab
setlocal shiftwidth=4
let b:undo_ftplugin .= '|setlocal expandtab< shiftwidth<'
if &l:softtabstop != -1
  let &l:softtabstop = &l:shiftwidth
  let b:undo_ftplugin .= '|setlocal softtabstop<'
endif
