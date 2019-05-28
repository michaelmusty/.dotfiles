" :compiler support for Z Shell syntax checking with `zsh -n`
if exists('current_compiler') || &compatible || !has('patch-7.4.191')
  finish
endif
let current_compiler = 'zsh'

CompilerSet makeprg=zsh\ -n\ --\ %:S
CompilerSet errorformat=%f:%l:\ %m
