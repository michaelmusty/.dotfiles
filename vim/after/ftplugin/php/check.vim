" php/check.vim: Use PHP binary to check scripts for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_php_check')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_php_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_php_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_php_check'

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PhpCheck
      \ :<C-U>call compiler#Make('php')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>PhpCheck'
