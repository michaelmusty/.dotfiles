" Z shell files
autocmd BufNewFile,BufRead
      \ *.zsh,.zprofile,zprofile,.zshrc,zshrc
      \ setfiletype zsh
autocmd BufNewFile,BufRead
      \ *
      \   if getline(1) =~ '^#!.*zsh$'
      \ |   setfiletype zsh
      \ | endif
