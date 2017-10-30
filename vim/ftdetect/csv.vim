" Add automatic commands to detect CSV files
augroup dfcsv
  autocmd!
  autocmd BufNewFile,BufRead
      \ *.csv
      \ setfiletype csv
augroup END
