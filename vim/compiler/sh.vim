" :compiler support for POSIX sh syntax checking with `sh -n`
if exists('current_compiler') || &compatible || !has('patch-7.4.191')
  finish
endif
let current_compiler = 'sh'

CompilerSet makeprg=sh\ -n\ --\ %:S
CompilerSet errorformat=%f:\ %l:\ %m
