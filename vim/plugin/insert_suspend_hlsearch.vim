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
" InsertEnter isn't an autocmd event until 7.0
if !has('autocmd') || v:version < 700
  finish
endif
let g:loaded_insert_suspend_hlsearch = 1

" When entering insert mode, copy the current value of the 'hlsearch' option
" into a script variable; if it's enabled, suspend it
function s:InsertEnter()
  let s:hlsearch = &hlsearch
  echo &hlsearch
  if s:hlsearch
    set nohlsearch
  endif
  return
endfunction

" When leaving insert mode, if 'hlsearch' was enabled when this operation
" started, restore it
function s:InsertLeave()
  if s:hlsearch
    set hlsearch
  endif
  return
endfunction

" Clear search highlighting as soon as I enter insert mode, and restore it
" once I leave it
augroup insert_suspend_hlsearch
  autocmd!
  autocmd InsertEnter
        \ *
        \ call <SID>InsertEnter()
  autocmd InsertLeave
        \ *
        \ call <SID>InsertLeave()
augroup END
