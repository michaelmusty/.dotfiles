" Perl 5 files
autocmd BufNewFile,BufRead
      \ *.pl,*.pm,*.t,Makefile.PL
      \ setfiletype perl
autocmd BufNewFile,BufRead
      \ *
      \   if getline(1) =~# '\m^#!.*\<perl\>'
      \ |   setfiletype perl
      \ | endif
