" Add automatic commands to find Xresources subfiles
augroup dfxdefaults
  autocmd BufNewFile,BufRead
    \ **/.Xresources.d/*
    \ setlocal filetype=xdefaults
augroup END
