" PHP files
autocmd BufNewFile,BufRead
      \ *.php
      \ setfiletype php
autocmd BufNewFile,BufRead
      \ *
      \   if getline(1) =~# '\m^#!.\<php\>'
      \ |   setfiletype php
      \ | endif
      \ | if getline(1) =~? '\m^<?php\>'
      \ |   setfiletype php
      \ | endif
