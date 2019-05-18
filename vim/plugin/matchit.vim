" Get matchit.vim, one way or another
if has('packages') && !has('nvim')
  packadd matchit
else
  runtime macros/matchit.vim
endif
