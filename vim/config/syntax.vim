" Options dependent on the syntax feature
if has('syntax')

  " Use syntax highlighting with 100 lines of context
  silent! syntax enable
  silent! syntax sync minlines=100

  " If we can, detect a light background, but default to a dark one
  if has('eval') && v:version >= 701
    call detect_background#DetectBackground()
  else
    set background=dark
  endif

endif
