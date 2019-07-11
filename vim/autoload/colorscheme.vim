" Reset colorscheme based on current colorscheme name
function! colorscheme#UpdateCursorline(colors_name, list) abort
  if index(a:list, a:colors_name) >= 0
    set cursorline
  else
    set nocursorline
  endif
endfunction
