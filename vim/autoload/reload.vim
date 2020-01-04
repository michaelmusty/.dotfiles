" Re-run filetype detection, if it's run before
function! reload#FileType() abort
  if exists('g:did_load_filetypes')
    doautocmd filetypedetect BufRead
  endif
endfunction

" Re-read .vimrc file, reloading filetypes afterwards to avoid masking
" filetype plugin settings
"
function! reload#Vimrc() abort
  noautocmd source $MYVIMRC
  call reload#FileType()
  redraw
  echomsg fnamemodify($MYVIMRC, ':p:~').' reloaded'
endfunction
