"
" colon_operator.vim: Select ranges and run colon commands on them, rather
" like the ! operator but for colon commands like :sort.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_colon_operator') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_colon_operator = 1

" Operator function starts typing an ex command with the operated range
" pre-specified
function! ColonOperator(type) abort
  call feedkeys(':''[,'']', 'n')
endfunction

" Set up mapping
nnoremap <Plug>(ColonOperator)
      \ :<C-U>set operatorfunc=ColonOperator<CR>g@
