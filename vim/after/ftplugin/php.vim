" Extra configuration for PHP scripts
if &filetype != 'php' || &compatible || v:version < 700
  finish
endif

" Use PHP itself for syntax checking
compiler php
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:current_compiler'
      \ . '|setlocal errorformat<'
      \ . '|setlocal makeprg<'

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

" Get rid of the core ftplugin's square-bracket maps on unload
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> [['
      \ . '|ounmap <buffer> [['
      \ . '|nunmap <buffer> ]]'
      \ . '|ounmap <buffer> ]]'
