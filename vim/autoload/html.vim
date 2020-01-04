" Tidy the whole buffer
function! html#Tidy() abort
  let view = winsaveview()
  %!tidy -quiet
  call winrestview(view)
endfunction
