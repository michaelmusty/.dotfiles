function! option#Split(expr, ...) abort
  if a:0 > 1
    echoerr 'Too many arguments'
  endif
  let keepempty = a:0 ? a:1 : 0
  let parts = split(a:expr, '\\\@<!,[, ]*', keepempty)
  return map#(parts, 'substitute(v:val, ''\\,'', '','', ''g'')')
endfunction
