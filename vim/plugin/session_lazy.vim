"
" session_lazy.vim: Automatically resume a session from the current directory,
" if no other filename arguments were passed to Vim.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_session_lazy') || &compatible
  finish
endif
if !has('autocmd') || v:version < 700
  finish
endif
let g:loaded_session_lazy = 1

" Set up
augroup session
  autocmd!
  autocmd VimEnter *
        \ call session_lazy#Thaw()
  autocmd VimLeavePre *
        \ call session_lazy#Freeze()
augroup END
