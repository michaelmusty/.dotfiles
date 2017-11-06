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

" Show an error-highlighted message and beep, but without a real :echoerr
function! s:Error(message)
  execute 'normal! \<Esc>'
  echohl ErrorMsg
  echomsg a:message
  echohl None
endfunction

" Test whether an option currently has a flag as part of its value
function! s:Has(option, flag)

  " Horrible :execute to get the option's current setting into a variable
  " (I couldn't get {curly braces} indirection to work)
  let l:current = ''
  execute 'let l:current = &' . a:option

  " If the flag we're toggling is longer than one character, this must by
  " necessity be a delimited option. I think all of those in VimL are
  " comma-separated. Extend the flag and value so that they'll still match at
  " the start and end. Otherwise, use them as-is.
  if strlen(a:flag) > 1
    let l:search_flag = ',' . a:flag . ','
    let l:search_value = ',' . l:current . ','
  else
    let l:search_flag = a:flag
    let l:search_value = l:current
  endif

  " Return whether
  return stridx(l:search_value, l:search_flag) > -1

endfunction

" Internal function to do the toggling
function! s:Toggle(option, flag, local)

  " Check for spurious option strings, we don't want to :execute anything funny
  if a:option =~# '\m\L'
    call s:Error('Illegal option name')
    return 0
  endif

  " Check the option actually exists
  if !exists('&' . a:option)
    call s:Error('No such option: ' . a:option)
    return 0
  endif

  " Choose which set command to use
  let l:set = a:local
        \ ? 'setlocal'
        \ : 'set'

  " Find whether the flag is set before the change
  let l:before = s:Has(a:option, a:flag)

  " Assign -= or += as the operation to run based on whether the flag already
  " appears in the option value or not
  let l:operation = l:before
        \ ? '-='
        \ : '+='

  " Try to set the option; suppress errors, we'll check our work
  silent! execute l:set
        \ . ' '
        \ . a:option . l:operation . escape(a:flag, '\ ')

  " Find whether the flag is set after the change
  let l:after = s:Has(a:option, a:flag)

  " If we made a difference, report the new value; if we didn't, admit it
  if l:before != l:after
    execute l:set . ' ' . a:option . '?'
  else
    call s:Error('Unable to toggle '.a:option.' flag '.a:flag)
  endif

  " Return value is whether we made a change
  return l:before != l:after

endfunction

" User commands wrapping around calls to the above function
command -nargs=+ -complete=option
      \ ToggleOptionFlag
      \ call <SID>Toggle(<f-args>, 0)
command -nargs=+ -complete=option
      \ ToggleOptionFlagLocal
      \ call <SID>Toggle(<f-args>, 1)
