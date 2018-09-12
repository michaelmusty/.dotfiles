"
" paste_hook.vim: Mapping target to add a self-clearing autocmd that unsets
" 'paste' on the next InsertLeave event, if set; intended for use as a prefix
" to an insert session to make it happen in paste mode.
"
" Author: Tom Ryder <tom@sanctum.geek.nz
" Copyright: Same as Vim itself
"
if exists('g:loaded_paste_hook') || &compatible
  finish
endif
if !exists('##InsertLeave')
  finish
endif
let g:loaded_paste_hook = 1

" Start paste mode, establish hook to end it
function! s:Set() abort

  " Do nothing if 'paste' is already set
  if &paste
    return
  endif

  " Turn on 'paste' mode and set up the hook to clear it the next time we
  " leave insert mode
  set paste
  augroup paste_hook
    autocmd!
    autocmd InsertLeave * call s:Clear()
  augroup END

endfunction

" End paste mode and clear the hook that called us
function! s:Clear() abort
  set nopaste
  autocmd! paste_hook InsertLeave
endfunction

" Set up mappings
nnoremap <silent> <unique>
      \ <Plug>(PasteHook)
      \ :<C-U>call <SID>Set()<CR>
