"
" colon_operator.vim: Select ranges and run colon commands on them, rather
" like the ! operator but for colon commands like :sort.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_colon_operator') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_colon_operator = 1

" Operator prompts for a command if it doesn't have one from a prior run, and
" then runs the command on the selected text
function! ColonOperator(type) abort
  if !exists('s:command')
    let s:command = input('g:', '', 'command')
  endif
  execute 'normal! :''[,'']'.s:command."\<CR>"
endfunction

" Clear command so that we get prompted to input it, set operator function,
" and return <expr> motions to run it
function! ColonMap() abort
  unlet! s:command
  set operatorfunc=ColonOperator
  return 'g@'
endfunction

" Set up mapping
nnoremap <expr> <silent> <unique>
      \ <Plug>(ColonOperator)
      \ ColonMap()
