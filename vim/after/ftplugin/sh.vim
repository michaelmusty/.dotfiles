" Include slashes as part of 'isk' so that e.g. 'local' in '/usr/local/mysql'
" doesn't highlight
let g:sh_isk='@,48-57,_,192-255,.,/'

" Assume POSIX, I never write Bourne
let g:is_posix=1

" Use han(1) as a man(1) wrapper for Bash files if available
if exists('b:is_bash') && executable('han')
  setlocal keywordprg=han
endif
