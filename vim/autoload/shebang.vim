" If the first line was changed in the last insert operation, re-run script
" detection
function! shebang#Update() abort
  if line("'[") == 1
    runtime scripts.vim
  endif
endfunction
