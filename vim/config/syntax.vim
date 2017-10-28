" Options dependent on the syntax feature
if has('syntax')

  " Use syntax highlighting with 100 lines of context
  silent! syntax enable
  silent! syntax sync minlines=100

  " Use my custom color scheme if possible, otherwise I'm happy with whatever
  " the default is, and it usually cares about my background
  set background=dark
  silent! colorscheme sahara
endif
