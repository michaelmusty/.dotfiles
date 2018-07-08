" Extra configuration for shell script
if &filetype != 'sh' || &compatible || v:version < 700
  finish
endif

" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments<'
      \ . '|setlocal formatoptions<'

" If subtype is Bash, set 'keywordprg' to han(1df)
if exists('b:is_bash')
  setlocal keywordprg=han
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal keywordprg<'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_sh_maps')
  finish
endif

" Choose check compiler based on file subtype
if exists('b:is_bash')
  let b:sh_check_compiler = 'bash'
elseif exists('b:is_kornshell')
  let b:sh_check_compiler = 'ksh'
else
  let b:sh_check_compiler = 'sh'
endif
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:sh_check_compiler'

" Set mappings
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>call compiler#Make(b:sh_check_compiler)<CR>
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>call compiler#Make('shellcheck')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'
