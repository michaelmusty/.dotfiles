" Make a bare URL into a link to itself
function! html#UrlLink() abort

  " Yank this whole whitespace-separated word
  normal! yiW
  " Open a link tag
  normal! i<a href="">
  " Paste the URL into the quotes
  normal! hP
  " Move to the end of the link text URL
  normal! E
  " Close the link tag
  normal! a</a>

endfunction

" Tidy the whole buffer
function! html#TidyBuffer() abort
  let view = winsaveview()
  %!tidy -quiet
  call winrestview(view)
endfunction

" Update a timestamp
function! html#TimestampUpdate() abort
  if !&modified
    return
  endif
  let cv = winsaveview()
  call cursor(1,1)
  let li = search('\m\C^\s*<em>Last updated: .\+</em>$', 'n')
  if li
    let date = substitute(system('date -u'), '\n$', '', '')
    let line = getline(li)
    call setline(li, substitute(line, '\S.*',
          \ '<em>Last updated: '.date.'</em>', ''))
  endif
  call winrestview(cv)
endfunction
