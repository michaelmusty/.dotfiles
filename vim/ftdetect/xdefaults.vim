" Add automatic commands to find Xresources subfiles
autocmd BufNewFile,BufRead
      \ **/.Xresources.d/*
      \ setfiletype xdefaults
