" Add an underline under a heading
function! markdown#Heading(char) abort
  let pos = getpos('.')
  let heading = getline(pos[1])
  let underline = repeat(a:char, strlen(heading))
  call append(pos[1], underline)
  let pos[1] += 1
  let pos[2] = 1
  call setpos('.', pos)
endfunction
