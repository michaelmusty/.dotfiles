" Add automatic commands to find Xresources subfiles
augroup dotfiles_ftdetect_xdefaults
  autocmd!
  autocmd BufNewFile,BufRead
        \ **/.Xresources.d/*
        \ setfiletype xdefaults
augroup END
