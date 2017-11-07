" Add automatic commands to detect TSV files
autocmd BufNewFile,BufRead
      \ *.tsv
      \ setfiletype tsv
