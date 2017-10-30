" Add automatic commands to detect TSV files
augroup dotfiles_ftdetect_tsv
  autocmd!
  autocmd BufNewFile,BufRead
        \ *.tsv
        \ setfiletype tsv
augroup END
