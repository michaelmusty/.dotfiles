" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" Strip trailing whitespace with \x
if has('eval')

  " Define function for stripping whitespace
  function! s:StripTrailingWhitespace()

    " Iterating line number
    let l:li = 1

    " Line number of the file's last line
    let l:ll = line('$')

    " Iterate over the lines
    while l:li <= l:ll

      " Get the line text
      let l:line = getline(l:li)

      " Replace the line with a subsitution of its text stripping extraneous
      " whitespace
      call setline(l:li, substitute(l:line, '\m\C\s\+$', '', 'g'))

      " Increment the line counter for the next iteration
      let l:li = l:li + 1
    endwhile
  endfunction

  " Map \x to the function just defined
  nnoremap <silent> <leader>x :<C-U>call <SID>StripTrailingWhitespace()<CR>

endif
