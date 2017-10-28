" Add automatic commands to detect .muttrc files
augroup dfmuttrc

  autocmd BufNewFile,BufRead
      \ **/.dotfiles/mutt/muttrc.d/*.rc
      \ setlocal filetype=muttrc

  autocmd BufNewFile,BufRead
      \ **/.muttrc.d/*.rc
      \ setlocal filetype=muttrc

augroup END
