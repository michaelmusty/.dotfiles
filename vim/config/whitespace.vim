" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" Strip trailing whitespace with \x
if has('eval')
  function! StripTrailingWhitespace()
    let l:search = @/
    %substitute/\s\+$//e
    let @/ = l:search
    nohlsearch
  endfunction
  nnoremap <silent> <leader>x :<C-U>call StripTrailingWhitespace()<CR>
endif
