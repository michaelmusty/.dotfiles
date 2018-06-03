" Add automatic commands to find Xresources subfiles
autocmd BufNewFile,BufRead
      \ .Xresources,*/.Xresources.d/*
      \ setfiletype xdefaults
