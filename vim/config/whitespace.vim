" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" Strip trailing whitespace with \x
if has('eval')
  function! s:StripTrailingWhitespace()
    let l:li = 1
    let l:ll = line('$')
    while l:li <= l:ll
      let l:line = getline(l:li)
      call setline(l:li, substitute(l:line, '\m\C\s\+$', '', 'g'))
      let l:li = l:li + 1
    endwhile
  endfunction
  nnoremap <silent> <leader>x :<C-U>call <SID>StripTrailingWhitespace()<CR>
endif
