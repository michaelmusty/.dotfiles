function! html#timestamp#Update() abort
  if !&modified
    return
  endif
  let l:cv = winsaveview()
  call cursor(1,1)
  let l:li = search('\C^\s*<em>Last updated: .\+</em>$', 'n')
  if l:li
    let l:date = substitute(system('date -u'), '\C\n$', '', '')
    let l:line = getline(l:li)
    call setline(l:li, substitute(l:line, '\C\S.*',
          \ '<em>Last updated: '.l:date.'</em>', ''))
  endif
  call winrestview(l:cv)
endfunction
