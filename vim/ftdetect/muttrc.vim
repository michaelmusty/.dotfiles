" Add automatic commands to detect .muttrc files
augroup dotfiles_ftdetect_muttrc
  autocmd!
  autocmd BufNewFile,BufRead
        \ **/.dotfiles/mutt/muttrc.d/*.rc,**/.muttrc.d/*.rc
        \ setfiletype muttrc
augroup END
