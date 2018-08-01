"
" equalalways_resized: If 'equalalways' is set, extend it to VimResized
" events.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_equalalways_resized') || &compatible
  finish
endif
if !has('autocmd') || !has('windows') || !exists('##VimResized')
  finish
endif
let g:loaded_equalalways_resized = 1

" If 'equalalways' is set, rebalance the windows
function! s:Rebalance() abort
  if &equalalways
    wincmd =
  endif
endfunction

" Add hook for VimResized event
augroup equalalways_resized
  autocmd!
  autocmd VimResized * call s:Rebalance()
augroup END
