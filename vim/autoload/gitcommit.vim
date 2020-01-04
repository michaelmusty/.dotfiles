" Choose the color column depending on non-comment line count
function! gitcommit#CursorColumn() abort

  " If we can find a line after the first that isn't a comment, we're
  " composing the message
  "
  for num in range(1, line('$'))
    if num == 1
      continue
    endif
    let line = getline(num)
    if strpart(line, 0, 1) !=# '#'
      return '+1'
    elseif line =~# '^# -\{24} >8 -\{24}$'
      break
    endif
  endfor

  " Otherwise, we're still composing our subject
  return '51'

endfunction
