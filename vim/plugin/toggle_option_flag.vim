"
" toggle_option_flag.vim: Provide commands to toggle flags in single-char
" grouped options like 'formatoptions', 'shortmess', 'complete' etc.
"
" This will fail hilariously if you try to set e.g. 'switchbuf' with it!
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_toggle_option_flag')
      \ || !has('user_commands')
      \ || &compatible
  finish
endif
let g:loaded_toggle_option_flag = 1

" Internal function to do the toggling
function! s:Toggle(option, flag, local)

  " Check for weird options, we don't want to :execute anything funny
  if a:option =~# '\m\L'
    echoerr 'Illegal option name'
    return
  endif

  " Weird flags, too; should be a single inoffensive char
  if a:flag !~# '\m^[\a.]$'
    echoerr 'Illegal flag'
    return
  endif

  " Choose which set command to use
  let l:set = a:local
        \ ? 'setlocal'
        \ : 'set'

  " :execute to assign -= or += to l:op for the option toggle
  " (I couldn't get {curly braces} indirection to work)
  let l:op = ''
  execute 'let l:op = &' . a:option . ' =~# a:flag ? "-=" : "+="'

  " Build the command strings to set and then show the value
  let l:cmd_set = l:set . ' ' . a:option . l:op . a:flag
  let l:cmd_show = l:set . ' ' . a:option . '?'

  " Run the set and show command strings
  execute l:cmd_set
  execute l:cmd_show

endfunction

" User commands wrapping around calls to the above function
command -nargs=+ -complete=option
      \ ToggleOptionFlag
      \ call <SID>Toggle(<f-args>, 0)
command -nargs=+ -complete=option
      \ ToggleOptionFlagLocal
      \ call <SID>Toggle(<f-args>, 1)
