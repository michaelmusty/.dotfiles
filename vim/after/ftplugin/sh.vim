" If the file is not already tagged as either ksh nor bash, assume POSIX shell
if !exists('g:is_kornshell') && !exists('g:is_bash')
  let g:is_posix = 1
endif

" Use han(1df) as a man(1) wrapper for Bash files if available
if exists('b:is_bash') && executable('han')
  setlocal keywordprg=han
endif
