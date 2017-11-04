" Default to POSIX shell, as I never write Bourne, and if I write Bash or Ksh
" it'll be denoted with either a shebang or an appropriate extension.
let g:is_posix = 1

"
" Setting g:is_posix above also prompts Vim's core syntax/sh.vim script to
" set g:is_kornshell and thereby b:is_kornshell to the same value as g:is_posix.
"
" That's very confusing, so before it happens we'll copy b:is_kornshell's
" value as determined by filetype.vim and ~/.vim/ftdetect/sh.vim into a custom
" variable b:is_ksh, before its meaning gets confused.
"
" b:is_ksh as a name is more inline with b:is_bash and b:is_sh, anyway, so
" we'll just treat b:is_kornshell like it's both misnamed and broken.
"
" We can then switch on our custom variable in ~/.vim/after/syntax/sh.vim to
" apply settings that actually *are* unique to Korn shell and its derivatives.
"
if exists('b:is_kornshell')
  let b:is_ksh = b:is_kornshell
endif

" Use han(1df) as a man(1) wrapper for Bash files if available
if exists('b:is_bash') && executable('han')
  setlocal keywordprg=han
endif

" Map checker based on shell family
if exists('b:is_bash') && b:is_bash
  let b:check = 'write !bash -n'
elseif exists('b:is_ksh') && b:is_ksh
  let b:check = 'write !ksh -n'
else
  let b:check = 'write !sh -n'
endif
nnoremap <buffer> <silent>
      \ <LocalLeader>c
      \ :<C-U>execute b:check<CR>

" Map linter based on shell family
if exists('b:is_bash') && b:is_bash
  let b:lint = 'write shellcheck -s bash -'
elseif exists('b:is_ksh') && b:is_ksh
  let b:lint = 'write !shellcheck -s ksh -'
else
  let b:lint = 'write !shellcheck -s sh -'
endif
nnoremap <buffer> <silent>
      \ <LocalLeader>l
      \ :<C-U>execute b:lint<CR>
