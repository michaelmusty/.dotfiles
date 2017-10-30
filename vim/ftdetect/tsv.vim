" Add automatic commands to detect TSV files
augroup dftsv
  autocmd!
  autocmd BufNewFile,BufRead
      \ *.tsv
      \ setfiletype tsv
augroup END
