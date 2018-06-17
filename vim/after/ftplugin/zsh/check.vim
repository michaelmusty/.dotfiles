" zsh/check.vim: Use Z shell binary to check for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_zsh_check')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_zsh_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_zsh_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_zsh_check'

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>ZshCheck
      \ :<C-U>call compiler#Make('zsh')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>ZshCheck'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>ZshCheck')
  nmap <buffer> <unique>
        \ <LocalLeader>c
        \ <Plug>ZshCheck
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>c'
endif
