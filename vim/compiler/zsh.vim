" :compiler support for Z Shell syntax checking with `zsh -n`
if exists('current_compiler') || &compatible || v:version < 800
  finish
endif
let current_compiler = 'zsh'

CompilerSet makeprg=zsh\ -n\ --\ %:S
CompilerSet errorformat=%f:%l:\ %m
