" Extra configuration for Git commit messages
if &filetype != 'gitcommit' || &compatible || v:version < 700
  finish
endif

" Make angle brackets behave like mail quotes
setlocal comments+=n:>
setlocal formatoptions+=coqr

" Add to undo script
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal comments<'
        \ . '|setlocal formatoptions<'
endif
