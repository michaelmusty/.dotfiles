"
" Replace Vim's stock PHP filetype plugin, reimplementing only the part I
" actually need: the matchit.vim keyword pairs.
"
" This is mostly because the stock file pulls in HTML's filetype plugins too,
" without providing a variable check to stop it. That causes absurd problems
" with defining HTML checkers/linters in the rest of my files.
"
if exists('b:did_ftplugin') || &compatible
  finish
endif
let b:did_ftplugin = 1

" Define keywords for matchit.vim
if exists('g:loaded_matchit')
  let b:match_words = '<?php:?>'
        \ . ',\<do\>:\<while\>'
        \ . ',\<for\>:\<endfor\>'
        \ . ',\<foreach\>:\<endforeach\>'
        \ . ',\<if\>:\<elseif\>:\<else\>:\<endif\>'
        \ . ',\<switch\>:\<endswitch\>'
        \ . ',\<while\>:\<endwhile\>'
endif

" Define how to undo this plugin's settings
let b:undo_ftplugin = 'unlet b:match_words'
