" Assume POSIX, I never write Bourne
let g:is_posix=1

" Use han(1df) as a man(1) wrapper for Bash files if available
if exists('b:is_bash') && executable('han')
  setlocal keywordprg=han
endif
