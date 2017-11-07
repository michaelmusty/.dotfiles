" If we know we have another shell type, clear away the others completely, now
" that core syntax/sh.vim is done prodding /bin/sh to determine the system
" shell type (which I don't care about).
if exists('b:is_bash')
  unlet! b:is_sh b:is_posix b:is_kornshell
elseif exists('b:is_kornshell')
  unlet! b:is_sh b:is_posix
elseif exists('b:is_posix')
  unlet! b:is_sh
endif

" Some corrections for highlighting if we have any of POSIX, Bash, or Ksh
if exists('g:is_posix') || exists('b:is_bash') || exists('b:is_ksh')

  " The syntax highlighter seems to flag '/baz' in '"${foo:-"$bar"/baz}"' as an
  " error, and I'm pretty sure it's not, at least in POSIX sh, Bash, and Ksh.
  syntax clear shDerefWordError

  " The syntax highlighter doesn't match parens for subshells for 'if' tests
  " correctly if they're on separate lines. This happens enough that it's
  " probably not worth keeping the error.
  syntax clear shParenError

endif

" Some corrections for highlighting specific to the Bash mode
if exists('b:is_bash')

  " I don't like bashAdminStatement; these are not keywords, they're just
  " strings for init scripts.
  syntax clear bashAdminStatement

  " Reduce bashStatement down to just builtins; highlighting 'grep' is not
  " very useful. This list was taken from `compgen -A helptopic` on Bash
  " 4.4.5.
  syntax clear bashStatement
  syntax keyword bashStatement
        \ .
        \ :
        \ alias
        \ bg
        \ bind
        \ break
        \ builtin
        \ caller
        \ cd
        \ command
        \ compgen
        \ complete
        \ compopt
        \ continue
        \ coproc
        \ dirs
        \ disown
        \ echo
        \ enable
        \ eval
        \ exec
        \ exit
        \ false
        \ fc
        \ fg
        \ function
        \ getopts
        \ hash
        \ help
        \ history
        \ jobs
        \ kill
        \ let
        \ logout
        \ mapfile
        \ popd
        \ printf
        \ pushd
        \ pwd
        \ read
        \ readarray
        \ readonly
        \ return
        \ select
        \ set
        \ shift
        \ shopt
        \ source
        \ suspend
        \ test
        \ time
        \ times
        \ trap
        \ true
        \ type
        \ ulimit
        \ umask
        \ unalias
        \ until
        \ variables
        \ wait
endif
