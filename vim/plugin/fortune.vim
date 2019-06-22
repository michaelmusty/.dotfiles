command! -bar Fortune
      \ call fortune#()

function! s:FortuneVimEnter() abort
  if !argc() && line2byte('$') == -1
    try | Fortune | catch | endtry
  endif
endfunction

augroup fortune
  autocmd!
  autocmd VimEnter *
        \ call s:FortuneVimEnter()
augroup END
