" Choose the filename we'll use for these sessions
let g:session_lazy#active = 0
if !exists('g:session_lazy#filename')
  let g:session_lazy#filename = 'Session.vim'
endif

" If we started with no arguments, there's no active session, and there's a
" session file sitting right there, read it
function! session_lazy#Thaw()
  if !argc()
        \ && v:this_session ==# ''
        \ && filereadable(g:session_lazy#filename)
    let g:session_lazy#active = 1
    execute 'source ' . g:session_lazy#filename
  endif
endfunction

" Before we quit, if we opened this with a session automatically, save it back
" again, into the same file
function! session_lazy#Freeze()
  if g:session_lazy#active
        \ && g:session_lazy#filename ==# fnamemodify(v:this_session, ':t')
    execute 'mksession! ' . g:session_lazy#filename
  endif
endfunction
