" Options dependent on the syntax feature
if has('syntax')

  " Use syntax highlighting with 100 lines of context
  silent! syntax enable
  silent! syntax sync minlines=100

  " I almost always use a dark background, so use that version of the selected
  " colorscheme
  set background=dark

endif
