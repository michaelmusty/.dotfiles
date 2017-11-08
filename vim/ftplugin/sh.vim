"
" If we have a #!/bin/sh shebang and filetype.vim determined we were neither
" POSIX nor Bash nor Korn shell, we'll guess POSIX, just because it's far more
" likely that's what I want to write than plain Bourne shell.
"
" You're supposed to be able to do this by setting g:is_posix, but if that's
" set, the syntax file ends up setting g:is_kornshell for you too, for reasons
" I don't really understand. This method works though, and is cleaner than
" the other workaround I had been trying.
"
if exists('b:is_sh')
  unlet b:is_sh
  if !exists('b:is_bash') && !exists('b:is_kornshell')
    let b:is_posix = 1
  endif
endif

" Use han(1df) as a man(1) wrapper for Bash files if available
if exists('b:is_bash')
      \ && executable('han')
  setlocal keywordprg=han
endif

" Map checker based on shell family
if exists('b:is_bash')
  let b:sh_check = 'write !bash -n'
elseif exists('b:is_kornshell')
  let b:sh_check = 'write !ksh -n'
else
  let b:sh_check = 'write !sh -n'
endif
nnoremap <buffer> <silent>
      \ <LocalLeader>c
      \ :<C-U>execute b:sh_check<CR>

" Map linter based on shell family
if exists('b:is_bash')
  let b:sh_lint = 'write !shellcheck -s bash -'
elseif exists('b:is_kornshell')
  let b:sh_lint = 'write !shellcheck -s ksh -'
else
  let b:sh_lint = 'write !shellcheck -s sh -'
endif
nnoremap <buffer> <silent>
      \ <LocalLeader>l
      \ :<C-U>execute b:sh_lint<CR>

" Unload this filetype plugin
let b:undo_user_ftplugin
      \ = 'setlocal keywordprg<'
      \ . '|unlet! b:sh_check b:sh_lint'
      \ . '|silent! nunmap <LocalLeader>c'
      \ . '|silent! nunmap <LocalLeader>l'
