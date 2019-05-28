" :compiler support for shell script linting with ShellCheck
" <https://www.shellcheck.net/>
if exists('current_compiler') || &compatible || v:version < 800
  finish
endif
let current_compiler = 'shellcheck'

" Build 'makeprg' command line based on this buffer's shell script type
let s:set = 'CompilerSet makeprg=shellcheck\ -e\ SC1090\ -f\ gcc'
if exists('b:is_bash')
  let s:set = s:set . '\ -s\ bash'
elseif exists('b:is_kornshell')
  let s:set = s:set . '\ -s\ ksh'
else
  let s:set = s:set . '\ -s\ sh'
endif
execute s:set . '\ --\ %:S'

CompilerSet errorformat=%f:%l:%c:\ %m\ [SC%n]
