" Choose the color column depending on non-comment line count
function! gitcommit#CursorColumn() abort

  " Last line number
  let l:ll = line('$')

  " If we can find a line after the first that isn't a comment, we're
  " composing the message
  if l:ll > 1
    for l:li in range(2, l:ll)
      if getline(l:li) !~# '^\s*#'
        return '+1'
      endif
    endfor
  endif

  " Otherwise, we're still composing our subject
  return '51'

endfunction
