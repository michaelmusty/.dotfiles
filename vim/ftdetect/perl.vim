" If it's a new file in a bin, libexec, or scripts subdir that has a
" Makefile.PL, it's almost definitely Perl.
autocmd filetypedetect BufNewFile
      \ */bin/*
      \,*/libexec/*
      \,*/scripts/*
      \ if filereadable(expand('<afile>:p:h:h') . '/Makefile.PL')
      \|  setfiletype perl
      \|endif
