"
" Replace Vim's stock Markdown filetype plugin, reimplementing only the part I
" actually need: the options settings. I don't use the folding, anyway.
"
" This is mostly because the stock file pulls in HTML's filetype plugins too,
" without providing a variable check to stop it. That causes absurd problems
" with defining HTML checkers/linters in the rest of my files.
"
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" Support line continuation for this file
if &compatible
  let s:cpoptions_save = &cpoptions
  set cpoptions-=C
endif

" Set comment/quote patterns
setlocal comments=fb:*,fb:-,fb:+,n:>
setlocal commentstring=>\ %s

" Set format options
setlocal formatoptions+=tcqln
setlocal formatoptions-=ro

" Set list format patterns
let &l:formatlistpat = '^\s*\d\+\.\s\+\'
      \ .'\|^[-*+]\s\+\'
      \ .'\|^\[^\ze[^\]]\+\]:'

" Define how to undo this plugin's settings
let b:undo_ftplugin = 'setlocal comments<'
      \ . '|setlocal commentstring<'
      \ . '|setlocal formatoptions<'
      \ . '|setlocal formatlistpat<'

" Restore 'cpoptions' setting if we touched it
if exists('s:cpoptions_save')
  let &cpoptions = s:cpoptions_save
  unlet s:cpoptions_save
endif
