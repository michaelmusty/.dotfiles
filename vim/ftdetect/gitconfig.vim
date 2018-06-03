" Git config files
autocmd BufNewFile,BufRead
      \ *.git*/config,.gitconfig,.gitmodules
      \ setfiletype gitconfig
