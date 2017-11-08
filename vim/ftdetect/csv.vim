" Add automatic commands to detect CSV files
autocmd BufNewFile,BufRead
      \ *.csv
      \ setfiletype csv
