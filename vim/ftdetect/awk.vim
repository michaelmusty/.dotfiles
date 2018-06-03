" AWK files
autocmd BufNewFile,BufRead
      \ *.awk
      \ setfiletype awk
autocmd BufNewFile,BufRead
      \ *
      \   if getline(1) =~# '\m^#!.*\<[gm]\?awk\>'
      \ |   setfiletype awk
      \ | endif
