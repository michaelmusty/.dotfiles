"
" toggle_option_flag.vim: Provide commands to toggle flags in grouped options
" like 'formatoptions', 'shortmess', 'complete', 'switchbuf', etc.
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

  " Choose which set command to use
  let l:set = a:local
        \ ? 'setlocal'
        \ : 'set'

  " Make a flag pattern to allow us to search for the literal string with no
  " regular expression devilry at all
  let l:flag_pattern = escape(a:flag, '\')

  " Horrible :execute to get the option's current current into a variable
  " (I couldn't get {curly braces} indirection to work)
  let l:current = ''
  execute 'let l:current = &' . a:option

  " If the flag we're toggling is longer than one character, this must by
  " necessity be a delimited option. I think all of those in VimL are
  " comma-separated. Extend the pattern and current setting so that they'll
  " still match at the start and end.
  if len(a:flag) > 1
    let l:flag_pattern = ',' . l:flag_pattern . ','
    let l:current = ',' . l:current . ','
  endif

  " Assign -= or += as the operation to run based on whether the flag already
  " appears in the option value or not
  let l:operation = l:current =~# '\V\C' . l:flag_pattern ? '-=' : '+='

  " Build the command strings to set and then show the value
  let l:cmd_set = l:set . ' ' . a:option . l:operation . escape(a:flag, '\ ')
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
