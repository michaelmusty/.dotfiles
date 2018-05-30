"
" insert_suspend_hlsearch.vim: If 'hlsearch' is enabled, switch it off when
" the user starts an insert mode operation, and back on again when they're
" done.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_insert_suspend_hlsearch') || &compatible
  finish
endif
if !has('autocmd') || !has('extra_search') || v:version < 700
  finish
endif
let g:loaded_insert_suspend_hlsearch = 1

" Save the current value of the 'hlsearch' option in a script variable, and
" disable it if enabled. Note that :nohlsearch does not work for this; see
" :help autocmd-searchpat.
function s:HlsearchSuspend()
  let s:hlsearch = &hlsearch
  if s:hlsearch
    set nohlsearch
  endif
  return
endfunction

" Restore the value of 'hlsearch' from the last time s:HlsearchSuspend was
" called.
function s:HlsearchRestore()
  if s:hlsearch
    set hlsearch
  endif
  return
endfunction

" Clear search highlighting as soon as I enter insert mode, and restore it
" once left
augroup insert_suspend_hlsearch
  autocmd!
  autocmd InsertEnter
        \ *
        \ call <SID>HlsearchSuspend()
  autocmd InsertLeave
        \ *
        \ call <SID>HlsearchRestore()
augroup END
