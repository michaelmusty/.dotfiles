" Custom Vim help documentation filetype detection
autocmd BufNewFile,BufRead
      \ **/vim/**/doc/*.txt,**/.vim/**/doc/*.txt
      \ setlocal filetype=help
