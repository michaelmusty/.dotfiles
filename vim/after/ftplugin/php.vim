" Extra configuration for PHP scripts
if &filetype != 'php' || &compatible || v:version < 700
  finish
endif

" Set comment formats
setlocal comments=s1:/*,m:*,ex:*/,://,:#
setlocal formatoptions+=or
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments<'
      \ . '|setlocal formatoptions<'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_php_maps')
  finish
endif

" Set mappings
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>call compiler#Make('php')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'

" Get rid of the core ftplugin's square-bracket maps on unload
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> [['
      \ . '|ounmap <buffer> [['
      \ . '|nunmap <buffer> ]]'
      \ . '|ounmap <buffer> ]]'
