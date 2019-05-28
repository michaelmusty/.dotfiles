" :compiler support for Korn shell syntax checking with `ksh -n`
if exists('current_compiler') || &compatible || v:version < 800
  finish
endif
let current_compiler = 'ksh'

CompilerSet makeprg=ksh\ -n\ --\ %:S
CompilerSet errorformat=%f:\ %l:\ %m
