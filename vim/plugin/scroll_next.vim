"
" scroll_next.vim: Mapping to scroll a page forward with CTRL-F until the last
" line is visible in the buffer (if supported) or the cursor is on the last
" line, and to run :next instead if so to move to the next buffer in the
" argument list.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_scroll_next') || &compatible
  finish
endif
if v:version < 600
  finish
endif
let g:loaded_scroll_next = 1

" Check visibility of last line (Vim >=7.0) or cursor presence on last line
" and flick to :next if appropriate, or just page forward with CTRL-F
function! s:ScrollNext() abort
  if line('.') == line('$')
        \ || line('w$') == line('$')
    silent! next
  else
    execute "normal! \<C-F>"
  endif
endfunction

" Mapping setup
nnoremap <silent> <unique>
      \ <Plug>(ScrollNext)
      \ :<C-U>call <SID>ScrollNext()<CR>
