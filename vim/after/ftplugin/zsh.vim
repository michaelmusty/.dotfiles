" Use Z shell itself as a syntax checker
compiler zsh
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal errorformat< makeprg<'

" Fold based on indent level
setlocal foldmethod=indent
let b:undo_ftplugin .= '|setlocal foldmethod<'
