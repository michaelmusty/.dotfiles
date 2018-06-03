" If we don't have packages (Vim < 8.0), try to load matchit.vim from the
" older macros location in the distributed runtime instead
if !has('packages')
  silent! runtime macros/matchit.vim
endif
