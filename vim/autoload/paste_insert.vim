function! paste_insert#() abort
  augroup paste_insert
    autocmd!
    autocmd CursorHold,CursorMoved,User *
          \ set nopaste paste?
          \|autocmd! paste_insert
    autocmd InsertEnter *
          \ autocmd paste_insert InsertLeave *
                \ doautocmd paste_insert User
  augroup END
  set paste paste?
endfunction
