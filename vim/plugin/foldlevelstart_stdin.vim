"
" foldlevelstart_stdin.vim: Set 'foldlevel' to 'foldlevelstart' after reading
" from standard input, which Vim doesn't do by default.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_foldlevelstart_stdin') || &compatible
  finish
endif
if !has('autocmd') || !has('folding') || !exists('##StdinReadPre')
  finish
endif
let g:loaded_foldlevelstart_stdin = 1

" Check if 'foldlevelstart' is non-negative, and set 'foldlevel' to its value
" if it is
function! s:SetFoldlevel() abort
  if &foldlevelstart >= 0
    let &l:foldlevel = &foldlevelstart
  endif
endfunction

" Watch for stdin reads and set fold level accordingly
augroup foldlevelstart_stdin
  autocmd!
  autocmd StdinReadPre * call s:SetFoldlevel()
augroup END
