" Explicitly set indent level; this matches the global default, but it's tidy
" to enforce it in case we changed from a filetype with different value (e.g.
" VimL)
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

" Default to POSIX shell, as I never write Bourne, and if I write Bash or Ksh
" it'll be denoted with either a shebang or an appropriate extension. At the
" time of writing, changing this also prompts sh.vim to set g:is_kornshell,
" which is absurd, and requires a bit more massaging in after/syntax/sh.vim to
" turn off some unwanted stuff.
let g:is_posix = 1

" Use han(1df) as a man(1) wrapper for Bash files if available
if exists('b:is_bash') && executable('han')
  setlocal keywordprg=han
endif
