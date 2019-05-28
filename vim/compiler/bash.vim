" :compiler support for GNU Bash syntax checking with `bash -n`
if exists('current_compiler') || &compatible || v:version < 800
  finish
endif
let current_compiler = 'bash'

CompilerSet makeprg=bash\ -n\ --\ %:S
CompilerSet errorformat=%f:\ line\ %l:\ %m
