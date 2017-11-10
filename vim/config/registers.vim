" Change and delete with C and D both cut off the remainder of the line from
" the cursor, but Y yanks the whole line, which is inconsistent (and can be
" done with yy anyway); this fixes it so it only yanks the rest of the line
nnoremap Y y$
