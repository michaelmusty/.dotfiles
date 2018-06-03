" Add automatic commands to detect .muttrc files
autocmd BufNewFile,BufRead
      \ Muttrc,.muttrc,*muttrc.d/*.rc
      \ setfiletype muttrc
