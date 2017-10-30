" Add automatic commands to detect CSV files
augroup dotfiles_ftdetect_csv
  autocmd!
  autocmd BufNewFile,BufRead
        \ *.csv
        \ setfiletype csv
augroup END
