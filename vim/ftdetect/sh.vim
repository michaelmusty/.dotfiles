" Add automatic commands to choose shell flavours based on filename pattern
augroup dfsh
  autocmd!

  " Names/paths of things that are Bash shell script
  autocmd BufNewFile,BufRead
        \ **/.dotfiles/bash/**,bash-fc-*
        \ let b:is_bash = 1 |
        \ setfiletype sh

  " Names/paths of things that are Korn shell script
  autocmd BufNewFile,BufRead
        \ **/.dotfiles/ksh/**,.kshrc,*.ksh
        \ let b:is_kornshell = 1 |
        \ setfiletype sh

  " Names/paths of things that are POSIX shell script
  autocmd BufNewFile,BufRead
        \ **/.dotfiles/sh/**,.shinit,.shrc,.xinitrc,/etc/default/*
        \ let b:is_posix = 1 |
        \ setfiletype sh

augroup END
