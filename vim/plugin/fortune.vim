command! -bar Fortune
      \ call fortune#()
augroup fortune
  autocmd!
  autocmd VimEnter *
        \ if !argc() && line2byte('$') == -1 | Fortune | endif
augroup END
