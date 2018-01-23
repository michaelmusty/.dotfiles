" Options dependent on the syntax feature
if has('syntax') && !has('g:syntax_on')

  " Use syntax highlighting with 100 lines of context
  silent! syntax enable
  silent! syntax sync minlines=100

  " If we can, detect a light background, but default to a dark one. This is
  " only because it's more likely the author of this configuration will be
  " using one.
  if v:version >= 701
    silent! let &background = detect_background#DetectBackground()
  else
    set background=dark
  endif

  " The 'sahara' colorscheme only works for dark backgrounds with 256 colors
  if &background ==# 'dark' && (has('gui_running') || &t_Co == 256)
    silent! colorscheme sahara
  endif

endif
