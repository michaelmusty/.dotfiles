" Options dependent on the syntax feature
if has('syntax')

  " Use syntax highlighting with 100 lines of context
  silent! syntax enable
  silent! syntax sync minlines=100

  " Invert Vim's built-in logic for choosing dark or light backgrounds; we'll
  " default to choosing a dark background unless we find some reason *not* to.
  if has('eval') && v:version >= 701

    " Wrap all this logic in a function
    function! DetectBackground()

      " Split up the value of $COLORFGBG (if any) by semicolons
      let l:colorfgbg = split($COLORFGBG, ';')

      " Get the background color value, or an empty string if none
      let l:bg = len(l:colorfgbg) ? l:colorfgbg[-1] : ''

      " Choose the background setting based on this value
      if l:bg ==# 'default' || l:bg ==# '7' || l:bg ==# '15'
          set background=light
      else
          set background=dark
      endif

    endfunction

    " Call the function just defined directly
    call DetectBackground()

  " Ancient or cut-down Vim? Just go dark
  else
    set background=dark
  endif

endif
