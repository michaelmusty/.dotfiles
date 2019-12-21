" Add an underline under a heading
function! markdown#Heading(char) abort

  " Get current position
  let pos = getpos('.')

  " Get heading text from current line
  let heading = getline(pos[1])

  " Build underline string by repeating character by the string length of the
  " heading text
  "
  let underline = repeat(a:char, strlen(heading))

  " If the line after this one looks like it's already an underline, replace
  " it; otherwise, create a new underline
  "
  if getline(pos[1] + 1) =~# '^[-=]\{2,}$'
    call setline(pos[1] + 1, underline)
  else
    call append(pos[1], underline)
  endif

  " Move to the first column of the underline we just inserted
  let pos[1] += 1
  let pos[2] = 1
  call setpos('.', pos)

endfunction
