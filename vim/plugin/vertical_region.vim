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

" Function for expression maps returning navigaton keys to press
function! s:VerticalRegion(count, up, mode) abort

  " Get line and column number
  let l:num = line('.')
  let l:col = col('.')

  " Move up or down through buffer, counting hits as we go
  let l:hits = 0
  while a:up ? l:num > 1 : l:num < line('$')

    " Increment or decrement line number
    let l:num += a:up ? -1 : 1

    " If the line has any non-space characters up to the current column, we
    " have a hit; break the loop as soon as we have the count we need
    let l:line = getline(l:num)
    if strpart(l:line, 0, l:col) =~# '\S'
      let l:hits += 1
      if l:hits == a:count
        break
      endif
    endif

  endwhile

  " If not moving linewise for operator mode and not in first column, move to
  " same column after line jump; is there a way to do this in one jump?
  let l:keys = l:num . 'G'
  if a:mode !=# 'o' && l:col > 1
    let l:keys .= l:col - 1 . 'l'
  endif

  " Return normal mode commands
  return l:keys

endfunction

" Define plugin maps
nnoremap <expr> <Plug>(VerticalRegionUpNormal)
      \ <SID>VerticalRegion(v:count1, 1, 'n')
nnoremap <expr> <Plug>(VerticalRegionDownNormal)
      \ <SID>VerticalRegion(v:count1, 0, 'n')
onoremap <expr> <Plug>(VerticalRegionUpOperator)
      \ <SID>VerticalRegion(v:count1, 1, 'o')
onoremap <expr> <Plug>(VerticalRegionDownOperator)
      \ <SID>VerticalRegion(v:count1, 0, 'o')
xnoremap <expr> <Plug>(VerticalRegionUpVisual)
      \ <SID>VerticalRegion(v:count1, 1, 'x')
xnoremap <expr> <Plug>(VerticalRegionDownVisual)
      \ <SID>VerticalRegion(v:count1, 0, 'x')
