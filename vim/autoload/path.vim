function! path#Create(name, ...) abort
  if a:0 > 2
    echoerr 'Too many arguments'
  endif
  if isdirectory(a:name)
    return 1
  endif
  let name = a:name
  let path = 'p'
  let prot = a:0 == 1 && a:1 ? 0700 : 0755
  return mkdir(name, path, prot)
endfunction
