augroup paste_insert
  autocmd!
augroup END

function! paste_insert#() abort
  autocmd! paste_insert
  autocmd paste_insert CursorHold,CursorMoved,User <buffer>
        \ set nopaste paste?
        \|autocmd! paste_insert
  autocmd paste_insert InsertEnter <buffer>
        \ set paste paste?
        \|autocmd paste_insert InsertLeave <buffer>
              \ doautocmd paste_insert User
endfunction
