"
" vertical_region.vim: Move to a line that has non-space characters before or
" in the current column, usually to find lines that begin or end blocks in
" languages where indenting is used to show or specify structure.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_vertical_region') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_vertical_region = 1

" Define plugin maps
nnoremap <expr> <Plug>(VerticalRegionUpNormal)
      \ vertical_region#Map(v:count1, 1, 'n')
nnoremap <expr> <Plug>(VerticalRegionDownNormal)
      \ vertical_region#Map(v:count1, 0, 'n')
onoremap <expr> <Plug>(VerticalRegionUpOperator)
      \ vertical_region#Map(v:count1, 1, 'o')
onoremap <expr> <Plug>(VerticalRegionDownOperator)
      \ vertical_region#Map(v:count1, 0, 'o')
xnoremap <expr> <Plug>(VerticalRegionUpVisual)
      \ vertical_region#Map(v:count1, 1, 'x')
xnoremap <expr> <Plug>(VerticalRegionDownVisual)
      \ vertical_region#Map(v:count1, 0, 'x')
