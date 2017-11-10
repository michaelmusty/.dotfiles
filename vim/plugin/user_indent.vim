"
" user_indent.vim: When switching filetypes, look for a b:undo_user_indent
" variable and use it in much the same way the core's indent.vim does
" b:undo_indent in Vim >= 7.0. This allows you to undo your own indent files
" the same way you can the core ones.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_user_indent')
      \ || !has('autocmd')
      \ || &compatible
  finish
endif
let g:loaded_user_indent = 1

function! s:LoadUserIndent()
  if exists('b:undo_user_indent')
    execute b:undo_user_indent
    unlet b:undo_user_indent
  endif
endfunction

augroup user_indent
  autocmd!
  autocmd FileType * call s:LoadUserIndent()
augroup END
