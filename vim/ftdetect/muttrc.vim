" Add automatic commands to detect .muttrc files
autocmd BufNewFile,BufRead
      \ **/.dotfiles/mutt/muttrc.d/*.rc,**/.muttrc.d/*.rc
      \ setfiletype muttrc
