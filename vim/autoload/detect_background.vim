"
" detect_background.vim: Invert Vim's built-in logic for choosing dark or
" light backgrounds; we'll default to choosing a dark background unless we
" find some reason *not* to.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
function! detect_background#DetectBackground()

  " Split up the value of $COLORFGBG (if any) by semicolons
  let l:colorfgbg = split($COLORFGBG, ';')

  " Get the background color value, or an empty string if none
  let l:bg = len(l:colorfgbg)
        \ ? l:colorfgbg[-1]
        \ : ''

  " Choose the background setting based on this value
  if l:bg ==# 'default'
        \ || l:bg ==# '7'
        \ || l:bg ==# '15'
      set background=light
  else
      set background=dark
  endif

endfunction
