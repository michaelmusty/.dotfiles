" Add an underline under a heading
function! markdown#Heading(char) abort
  let heading = getline('.')
  let underline = repeat(a:char, strlen(heading))
  call append(line('.'), underline)
endfunction
