function! select_old_files#(...) abort
  if a:0
    if a:1 =~# '^\d\+$'
      let limit = a:1
    else
      echoerr 'Invalid count'
    endif
  elseif exists('g:select_old_files_limit')
    let limit = g:select_old_files_limit
  else
    let limit = &lines - 2
  endif
  let oldfiles = v:oldfiles
  let v:oldfiles = v:oldfiles[:limit - 1]
  browse oldfiles
  let v:oldfiles = oldfiles
endfunction
