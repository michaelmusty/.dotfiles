" Don't jump my screen around when I join lines, keep my cursor in the same
" place; this is done by dropping a mark first and then immediately returning
" to it; note that it wipes out your z mark, if you happen to use it
nnoremap J mzJ`z
