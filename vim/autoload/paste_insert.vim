function! paste_insert#() abort
  augroup paste_insert
    autocmd!
    autocmd CursorHold,CursorMoved,User <buffer>
          \ set nopaste paste?
          \|autocmd! paste_insert
    autocmd InsertEnter <buffer>
          \ set paste paste?
          \|autocmd paste_insert InsertLeave <buffer>
                \ doautocmd paste_insert User
  augroup END
endfunction
