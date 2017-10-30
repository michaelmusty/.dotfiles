" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" Strip trailing whitespace with \x
if has('eval')
  function! StripTrailingWhitespace()
    let l:li = 1
    for l:line in getline(1,'$')
      call setline(l:li, substitute(l:line, '\m\C\s\+$', '', 'g'))
      let l:li = l:li + 1
    endfor
  endfunction
  nnoremap <silent> <leader>x :<C-U>call StripTrailingWhitespace()<CR>
endif
