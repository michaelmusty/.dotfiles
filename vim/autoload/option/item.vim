function! option#item#Escape(item, ...) abort
  if a:0 > 1
    echoerr 'Too many arguments'
  endif
  let item = a:item
  let wild = a:0 ? a:1 : 0
  if wild
    let item = escape(item, '\*?[{`''$~')
  endif
  return escape(item, ',')
endfunction
