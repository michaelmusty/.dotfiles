"
" option_flags.vim: Provide functions to toggle flags in single-char grouped
" options like 'formatoptions', 'shortmess', 'complete' etc.
"
" This will fail hilariously if you try to set e.g. 'switchbuf' with it!
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if has('eval')

  " Public wrapper function to toggle a flag with 'set'
  function! option_flags#toggle(option, flag)
    call s:toggle(a:option, a:flag, 0)
  endfunction

  " Public wrapper function to toggle a flag with 'setlocal'
  function! option_flags#toggle_local(option, flag)
    call s:toggle(a:option, a:flag, 1)
  endfunction

  " Internal function to do the toggling
  function! s:toggle(option, flag, local)

    " Check for weird options, we don't want to eval() anything funny
    if a:option =~# '[^a-z]'
      echoerr 'Illegal option name'
      return
    endif

    " Weird flags, too; should be a single inoffensive char
    if a:flag !~# '^[a-z0-9.]$'
      echoerr 'Illegal flag'
      return
    endif

    " Choose which set command to use
    if a:local
      let l:set = 'setlocal '
    else
      let l:set = 'set '
    endif

    " Use eval() to assign -= or += to l:op for the option toggle
    " (I couldn't get {curly braces} indirection to work)
    let l:op = ''
    execute 'let l:op = &'.a:option.' =~# a:flag ? "-=" : "+="'

    " Use eval() to perform the option toggle and then print the value
    execute l:set . ' ' . a:option . l:op . a:flag . ' ' . a:option . '?'

  endfunction

endif
