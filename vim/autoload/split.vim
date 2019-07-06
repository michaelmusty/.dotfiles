if v:version < 702 || v:version == 702 && !has('patch-61')
  runtime autoload/unescape.vim
endif

function! split#Option(expr, ...) abort
  if a:0 > 2
    echoerr 'Too many arguments'
  endif
  let keepempty = a:0 ? a:1 : 0
  let parts = split(a:expr, '\\\@<!,[, ]*', keepempty)
  return map#(parts, function('unescape#Item'))
endfunction
