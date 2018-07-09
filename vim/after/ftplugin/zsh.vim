" Extra configuration for Z shell scripts
if &filetype != 'zsh' || &compatible || v:version < 700
  finish
endif

" Use Z shell itself as a syntax checker
compiler zsh
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:current_compiler'
      \ . '|setlocal errorformat<'
      \ . '|setlocal makeprg<'
