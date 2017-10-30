" Add automatic commands to find Xresources subfiles
augroup dfxdefaults
  autocmd!
  autocmd BufNewFile,BufRead
      \ **/.Xresources.d/*
      \ setfiletype xdefaults
augroup END
