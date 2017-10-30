" If g:is_posix is set, g:is_kornshell is probably set too, a strange decision
" by sh.vim. No matter; we can tease out whether this is actually a Korn shell
" script using our own b:is_kornshell_proper flag set at the end of
" ~/.vim/ftdetect/sh.vim, and if it isn't, we'll throw away the highlighting
" groups for ksh.
if exists('g:is_kornshell') && !exists('b:is_ksh')
  syntax clear kshSpecialVariables
  syntax clear kshStatement
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
