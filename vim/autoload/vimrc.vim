" Run some normal-mode keystrokes without jumping around
function! vimrc#Anchor(keys) abort
  let view = winsaveview()
  execute 'normal! '.a:keys
  call winrestview(view)
endfunction
