function! reload#FileType() abort
  if exists('g:did_load_filetypes')
    doautocmd filetypedetect BufRead
  endif
endfunction

function! reload#Vimrc() abort
  noautocmd source $MYVIMRC
  call reload#FileType()
  redraw
  echomsg fnamemodify($MYVIMRC, ':p:~').' reloaded'
endfunction
