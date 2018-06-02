" Perl 6 files
autocmd BufNewFile,BufRead
      \ *.p6,*.pl6,*.pm6
      \ setfiletype perl6
autocmd BufNewFile,BufRead
      \ *
      \   if getline(1) =~ '^#!.*perl6$'
      \ |   setfiletype perl6
      \ | endif
