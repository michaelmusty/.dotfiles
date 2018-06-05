" Add the packaged version of matchit.vim included in the distribution, if
" possible; plugin/macros.vim loads this for older Vims
if has('packages')
  silent! packadd! matchit
endif
