" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" Keep my cursor in place when I join lines
if has('eval')

  " Declare function
  function! s:StableNormalJoin()

    " Save current cursor position
    let l:lc = line('.')
    let l:cc = col('.')

    " Build and execute join command
    let l:command = '.,+' . v:count1 . 'join'
    execute l:command

    " Restore cursor position
    call cursor(l:lc, l:cc)

  endfunction

  " Remap J to the above function
  nnoremap <silent> J :<C-U>call <SID>StableNormalJoin()<CR>

endif
