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

endif
