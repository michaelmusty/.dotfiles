" When wrapping text, if a line is so long that not all of it can be shown on
" the screen, show as much as possible anyway; by default Vim fills the left
" column with @ symbols instead, which I don't find very helpful
set display=lastline

" Don't wrap by default, but use \w to toggle it on or off quickly
set nowrap
nnoremap <leader>w :set wrap!<CR>

" When wrapping, j and k should move by screen row, and not to the same
" column number in the previous logical line, which feels very clumsy and is
" seldom particularly helpful; you can use n| to jump to the nth column in a
" line anyway if you need to
nnoremap j gj
nnoremap k gk
