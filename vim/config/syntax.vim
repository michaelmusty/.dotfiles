" Options dependent on the syntax feature
if has('syntax') && !has('g:syntax_on')

  " Use syntax highlighting with 100 lines of context
  silent! syntax enable
  silent! syntax sync minlines=100

  " Opinionated; if the author is using color at all, it will probably be with
  " a dark background
  set background=dark

  " The 'sahara' colorscheme only works in the GUI or with 256 colors
  if has('gui_running') || &t_Co >= 256
    silent! colorscheme sahara
  endif

endif
