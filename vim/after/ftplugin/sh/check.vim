" sh/check.vim: Use appropriate shell binary to check scripts for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_sh_check')
  finish
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_sh_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_sh_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_sh_check'

" Choose compiler based on file subtype
if exists('b:is_bash')
  let b:sh_check_compiler = 'bash'
elseif exists('b:is_kornshell')
  let b:sh_check_compiler = 'ksh'
else
  let b:sh_check_compiler = 'sh'
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>ShCheck
      \ :<C-U>call compiler#Make(b:sh_check_compiler)<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>ShCheck'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>ShCheck')
  nmap <buffer> <unique>
        \ <LocalLeader>c
        \ <Plug>ShCheck
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>c'
endif
