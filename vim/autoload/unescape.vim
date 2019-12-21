" Unescape a list item escaped with escape#Item(), by replacing all escaped
" commas with unescaped ones
function! unescape#Item(key, val) abort
  return substitute(a:val, '\\,', ',', 'g')
endfunction
