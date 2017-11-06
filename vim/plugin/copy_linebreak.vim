"
" copy_linebreak.vim: Bind user-defined key sequences to toggle a group of
" options that make text wrapped with 'wrap' copy-paste friendly. Also creates
" user commands if it can.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_copy_linebreak')
      \ || !has('linebreak')
      \ || &compatible
  finish
endif
let g:loaded_copy_linebreak = 1

" Enable copy-friendly linebreak options
function! s:CopyLinebreakEnable()
  setlocal nolinebreak linebreak?
  setlocal showbreak=
  if exists('&breakindent')
    setlocal nobreakindent
  endif
endfunction

" Disable copy-friendly linebreak options
function! s:CopyLinebreakDisable()
  setlocal linebreak linebreak?
  setlocal showbreak<
  if exists('&breakindent')
    setlocal breakindent<
  endif
endfunction

" Toggle copy-friendly linebreak options, using the current setting for the
" 'linebreak' option as the pivot
function! s:CopyLinebreakToggle()
  if &linebreak
    call <SID>CopyLinebreakEnable()
  else
    call <SID>CopyLinebreakDisable()
  endif
endfunction

" Provide mappings to the function just defined
noremap <silent> <unique>
      \ <Plug>CopyLinebreakEnable
      \ :<C-U>call <SID>CopyLinebreakEnable()<CR>
noremap <silent> <unique>
      \ <Plug>CopyLinebreakDisable
      \ :<C-U>call <SID>CopyLinebreakDisable()<CR>
noremap <silent> <unique>
      \ <Plug>CopyLinebreakToggle
      \ :<C-U>call <SID>CopyLinebreakToggle()<CR>

" Provide user commands if we can
if has('user_commands')
  command -nargs=0
        \ CopyLinebreakEnable
        \ call <SID>CopyLinebreakEnable
  command -nargs=0
        \ CopyLinebreakDisable
        \ call <SID>CopyLinebreakDisable
  command -nargs=0
        \ CopyLinebreakToggle
        \ call <SID>CopyLinebreakToggle
endif
