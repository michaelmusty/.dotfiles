if exists('g:loaded_delimit_operator') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_delimit_operator = 1

nnoremap <expr> <Plug>(DelimitOperator)
      \ delimit_operator#Map()
xnoremap <expr> <Plug>(DelimitOperator)
      \ delimit_operator#Map()
