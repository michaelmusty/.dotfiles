" Run a filter over the entire buffer, but save the window position and
" restore it after doing so
function! filter#Stable(command) abort
  let l:view = winsaveview()
  execute '%!' . a:command
  call winrestview(l:view)
endfunction
