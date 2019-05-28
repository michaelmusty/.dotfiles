" :compiler support for POSIX sh syntax checking with `sh -n`
if exists('current_compiler') || &compatible || v:version < 800
  finish
endif
let current_compiler = 'sh'

CompilerSet makeprg=sh\ -n\ --\ %:S
CompilerSet errorformat=%f:\ %l:\ %m
