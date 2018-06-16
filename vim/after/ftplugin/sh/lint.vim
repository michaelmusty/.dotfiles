" sh/lint.vim: Use appropriate shell binary to lint scripts for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_sh_lint')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_sh_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_sh_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_sh_lint'

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>ShLint
      \ :<C-U>call compiler#Make('shellcheck')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>ShLint'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>ShLint')
  nmap <buffer> <unique>
        \ <LocalLeader>l
        \ <Plug>ShLint
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>l'
endif
