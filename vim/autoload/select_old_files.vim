function! select_old_files#() abort
  let oldfiles = v:oldfiles
  let limit = get(g:, 'select_old_files_limit', &lines - 1)
  let v:oldfiles = v:oldfiles[:limit-2]
  browse oldfiles
  let v:oldfiles = oldfiles
endfunction
