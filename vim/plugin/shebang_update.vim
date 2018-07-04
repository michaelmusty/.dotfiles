"
" shabeng_update.vim: If the first line of a file was changed, re-run
" scripts.vim to do shebang detection to update the filetype.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_shebang_update') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_shebang_update = 1

" Call the update function whenever leaving insert mode
augroup shebang_update
  autocmd!
  autocmd InsertLeave * call shebang#Update()
augroup END
