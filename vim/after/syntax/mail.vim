" mail.vim's quoting rules are overcomplicated and get too much wrong, just
" turn them off
syn region mailQuoted keepend contains=mailVerbatim,mailHeader,@mailLinks,mailSignature,@NoSpell start="^\z([a-z]\+>[]|}>]\)" end="^\z1\@!" fold
highlight link mailQuoted Comment
highlight! link mailQuoted1 NONE
highlight! link mailQuoted2 NONE
highlight! link mailQuoted3 NONE
highlight! link mailQuoted4 NONE
highlight! link mailQuoted5 NONE
highlight! link mailQuoted6 NONE

