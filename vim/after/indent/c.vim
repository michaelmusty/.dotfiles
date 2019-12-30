" If the path to the file looks like the Vim sources, set 'shiftwidth' to 4
if expand('%:p') =~# '/vim.*src/'
  setlocal shiftwidth=4
endif
