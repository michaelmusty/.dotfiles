" Set 'commentstring', 'define', and 'include' back to their default
" C-friendly values
setlocal commentstring&vim define&vim include&vim
let b:undo_ftplugin .= '|setlocal commentstring< define< include<'

" Include macros in completion
setlocal complete+=d
let b:undo_ftplugin .= '|setlocal complete<'

" Fold based on indent level
setlocal foldmethod=indent
let b:undo_ftplugin .= '|setlocal foldmethod<'

" Include system headers on UNIX
if has('unix')
  setlocal path+=/usr/include
  let b:undo_ftplugin .= '|setlocal path<'
endif
