" :compiler support for Vim script linting with Vint
" <https://github.com/Kuniwak/vint>
if exists('current_compiler') || &compatible || v:version < 800
  finish
endif
let current_compiler = 'vimlint'

CompilerSet makeprg=vint\ --\ %:S
CompilerSet errorformat=%f:%l:%c:\ %m
