" Set up short message settings
set shortmess=
" (file 3 of 5) -> (3 of 5)
set shortmess+=f
" [Incomplete last line] -> [eol]
set shortmess+=i
" 999 lines, 888 characters -> 999L, 888C
set shortmess+=l
" [Modified] -> [+]
set shortmess+=m
" [New File] -> [New]
set shortmess+=n
" Don't stack file writing messages
set shortmess+=o
" Don't stack file reading messages
set shortmess+=O
" [readonly] -> [RO]
set shortmess+=r
" written -> [w], appended -> [a]
set shortmess+=w
" [dos format] -> [dos]
set shortmess+=x
" Truncate file message at start if too long
set shortmess+=t
" Truncate other message in midle if too long
set shortmess+=T
" I donated to Uganda, thanks Bram
set shortmess+=I

" Don't show whitespace characters or end-of-line characters visually by
" default, but make \l toggle between them
set nolist
nnoremap <silent>
      \ <Leader>l
      \ :<C-U>setlocal list! list?<CR>

" Don't show line numbers by default, but \n toggles them
set nonumber
nnoremap <silent>
      \ <Leader>n
      \ :<C-U>setlocal number! number?<CR>
