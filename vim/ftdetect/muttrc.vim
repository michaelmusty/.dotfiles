" Add automatic commands to detect .muttrc files
augroup dfmuttrc
  autocmd!
  autocmd BufNewFile,BufRead
      \ **/.dotfiles/mutt/muttrc.d/*.rc,**/.muttrc.d/*.rc
      \ setfiletype muttrc
augroup END
