" Don't highlight errors for me; something not quite right here. The syntax
" highlighter seems to flag '/baz' in '"${foo:-"$bar"/baz}"' as an error, and
" I'm pretty sure it's not.
let g:sh_noerror = 1

" If the file is not already tagged as a shell type, default to POSIX shell,
" as I never write Bourne. I would set g:is_posix here rather than b:is_posix,
" but sh.vim makes some weird assumptions about me actually meaning ksh for
" some reason when I do that.
if !exists('b:is_kornshell') && !exists('b:is_bash') && !exists('b:is_posix')
  let b:is_posix = 1
endif

" Use han(1df) as a man(1) wrapper for Bash files if available
if exists('b:is_bash') && executable('han')
  setlocal keywordprg=han
endif
