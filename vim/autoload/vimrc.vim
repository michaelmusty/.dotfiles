" Get all buffer-local mappings into a string variable
function! vimrc#GetBufferLocalMaps() abort
  redir => l:out
  map <buffer>
  redir END
  let g:vimrc#buffer_local_maps = l:out
endfunction

" Clear all buffer-local mappings beginning with <LocalLeader>
function! vimrc#ClearLocalLeaderMaps() abort

  " Do nothing if there isn't a defined local leader
  if !exists('g:maplocalleader')
    return
  endif

  " Get all the buffer-local mappings into a list
  silent call vimrc#GetBufferLocalMaps()
  let l:mappings = split(g:vimrc#buffer_local_maps, '\n')

  " Iterate through the mappings
  for l:mapping in l:mappings

    " Match the list mapping and mode; skip if no match
    let l:matchlist = matchlist(l:mapping, '\m\C^\(.\)\s\+\(\S\+\)')
    if !len(l:matchlist)
      continue
    endif
    let l:mode = l:matchlist[1]
    let l:sequence = l:matchlist[2]

    " If the mapping starts with our local leader, clear it
    if stridx(l:sequence, g:maplocalleader) == 0
      execute l:mode.'unmap <buffer> '.l:sequence
    endif

  endfor

endfunction
