"
" User-defined key mapping to keep cursor in place when joining lines in
" normal mode
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if has('eval')

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
  noremap <Plug>FixedJoin
        \ :<C-U>call <SID>FixedJoin()<CR>
endif
