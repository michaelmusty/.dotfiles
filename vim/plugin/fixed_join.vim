"
" fixed_join.vim: User-defined key mapping and optional command to keep cursor
" in place when joining lines in normal mode.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_fixed_join') || &compatible
  finish
endif
let g:loaded_fixed_join = 1

" Declare function
function! s:FixedJoin()

  " Save current cursor position
  let l:lc = line('.')
  let l:cc = col('.')

  " Build and execute join command
  let l:command = '.,+' . v:count1 . 'join'
  execute l:command

  " Restore cursor position
  call cursor(l:lc, l:cc)

endfunction

" Create mapping proxy to the function just defined
noremap <silent> <unique>
      \ <Plug>FixedJoin
      \ :<C-U>call <SID>FixedJoin()<CR>

" If there's no mapping to it already, try to bind normal-mode J to it, to
" simply replace the old functionality
nmap <unique>
      \ J
      \ <Plug>FixedJoin

" Create a command as well in case it's useful
if has('user_commands')
  command -nargs=0
        \ FixedJoin
        \ call <SID>FixedJoin()
endif
