"
" detect_background.vim: Invert Vim's built-in logic for choosing dark or
" light backgrounds; we'll default to choosing a dark background unless we
" find some reason *not* to.
"
" Return the string to which we think the option should be set, to allow the
" caller to use it as they see fit.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_detect_background') || &compatible
  finish
endif
let g:loaded_detect_background = 1

" Declare autoload function for 'background' set
function! detect_background#DetectBackground() abort

  " Split up the value of $COLORFGBG (if any) by semicolons
  let l:colorfgbg = split($COLORFGBG, ';')

  " Get the background color value, or an empty string if none
  let l:bg = len(l:colorfgbg)
        \ ? l:colorfgbg[-1]
        \ : ''

  " Choose the background setting based on this value
  if l:bg ==# 'default'
        \ || l:bg == 7
        \ || l:bg == 15
      return 'light'
  else
      return 'dark'
  endif

endfunction
