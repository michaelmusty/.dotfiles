function! path#Create(name, ...) abort
  if a:0 > 2
    echoerr 'Too many arguments'
  endif
  if isdirectory(a:name)
    return 1
  endif
  let prot = a:0 >= 1 ? a:1 : 0755
  return mkdir(a:name, 'p', prot)
endfunction
