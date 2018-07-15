"
" shebang_create_exec.vim: Make a file executable on first save if it starts with a
" shebang.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_shebang_create_exec') || &compatible
  finish
endif
if !has('autocmd') || !has('unix') || !exists('*shellescape')
  finish
endif
let g:loaded_shebang_create_exec = 1

" Set up hook for before writes to check the buffer for new shebangs
augroup shebang_create_exec
  autocmd!
  autocmd BufWritePre * call s:Check(expand('<afile>:p'))
augroup END

" If the buffer starts with a shebang and the file being saved to doesn't
" exist yet, set up a hook to make it executable after the write is done
function! s:Check(filename) abort
  if stridx(getline(1), '#!') == 0 && !filereadable(a:filename)
    autocmd shebang_create_exec BufWritePost <buffer>
          \ call s:Chmod(expand('<afile>:p'))
  endif
endfunction

" Make the file executable and clear away the hook that called us
function! s:Chmod(filename) abort
  autocmd! shebang_create_exec BufWritePost <buffer>
  call system('chmod +x '.shellescape(a:filename))
endfunction
