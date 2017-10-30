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

  " If we determined something is b:is_kornshell, tack on b:is_ksh as well so
  " we can still tease out what is actually a kornshell script after sh.vim is
  " done changing our options for us; it conflates POSIX with Korn shell.
  autocmd BufNewFile,BufRead
      \ *
      \ if exists('b:is_kornshell') |
      \   let b:is_ksh = 1 |
      \ endif

augroup END
