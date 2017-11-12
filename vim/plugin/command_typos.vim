"
" command_typos.vim: Tolerate typos like :Wq, :Q, or :Qa and do what I mean,
" including any arguments or modifiers; I fat-finger these commands a lot
" because I type them so rapidly, and they don't correspond to any other
" commands I use
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_command_typos') || &compatible || !has('user_commands')
  finish
endif
let g:loaded_command_typos = 1

" Define commands
command -bang -complete=file -nargs=?
      \ E
      \ edit<bang> <args>
command -bang -complete=file -nargs=?
      \ W
      \ write<bang> <args>
command -bang -complete=file -nargs=?
      \ WQ
      \ wq<bang> <args>
command -bang -complete=file -nargs=?
      \ Wq
      \ wq<bang> <args>
command -bang
      \ Q
      \ quit<bang>
command -bang
      \ Qa
      \ qall<bang>
command -bang
      \ QA
      \ qall<bang>
command -bang
      \ Wa
      \ wall<bang>
command -bang
      \ WA
      \ wa<bang>
