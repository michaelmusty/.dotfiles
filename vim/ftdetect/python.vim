" Python files
autocmd BufNewFile,BufRead
      \ *.py
      \ setfiletype python
autocmd BufNewFile,BufRead
      \ *
      \ if getline(1) =~# '\m^#!.*\<python[23]\?\>'
      \ |   setfiletype python
      \ | endif
