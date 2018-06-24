"
" Replace Vim's stock Markdown filetype plugin, reimplementing only the part I
" actually need: the options settings. I don't use the folding, anyway.
"
" This is mostly because the stock file pulls in HTML's filetype plugins too,
" without providing a variable check to stop it. That causes absurd problems
" with defining HTML checkers/linters in the rest of my files.
"
if exists('b:did_ftplugin') || &compatible
  finish
endif
let b:did_ftplugin = 1

" Set comment/quote patterns
setlocal comments=fb:*,fb:-,fb:+,n:>
setlocal commentstring=>\ %s

" Set format options
setlocal formatoptions+=tcqln
setlocal formatoptions-=ro

" Set list format patterns
if exists('+formatlistpat')
  let &l:formatlistpat = '^\s*\d\+\.\s\+'
        \ .'\|^[-*+]\s\+'
        \ .'\|^\[^\ze[^\]]\+\]:'
endif

" Define how to undo this plugin's settings
let b:undo_ftplugin = 'setlocal comments<'
      \ . '|setlocal commentstring<'
      \ . '|setlocal formatoptions<'
      \ . '|setlocal formatlistpat<'
