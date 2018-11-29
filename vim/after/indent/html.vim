" Clear away the flag we set to indent after paragraphs
unlet g:html_indent_inctags

" Don't re-indent lines on right-angle-bracket or enter
setlocal indentkeys-=<>>,<Return>
let b:undo_ftplugin .= '|setlocal indentkeys<'
