" Add automatic commands to detect .muttrc files
augroup dfmuttrc
  autocmd!
  autocmd BufNewFile,BufRead
      \ **/.dotfiles/mutt/muttrc.d/*.rc,**/.muttrc.d/*.rc
      \ setlocal filetype=muttrc
augroup END
