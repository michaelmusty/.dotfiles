function! paste_insert#() abort
  augroup paste_insert
    autocmd!
    autocmd User Error,Finish
          \ set nopaste paste? | autocmd! paste_insert
    autocmd CursorHold,CursorMoved,BufLeave,WinLeave *
          \ doautocmd paste_insert User Error
    autocmd InsertEnter *
          \ autocmd paste_insert InsertLeave *
                \ doautocmd paste_insert User Finish
  augroup END
  set paste paste?
endfunction
