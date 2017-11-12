" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_sh_posix') || &compatible
  finish
endif
let b:did_ftplugin_sh_posix = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_sh_posix'
endif

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
