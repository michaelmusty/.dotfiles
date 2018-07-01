" Extra configuration for 'php' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'php'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Set comment formats
setlocal comments=s1:/*,m:*,ex:*/,://,:#
setlocal formatoptions+=or
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments< formatoptions<'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_php_maps')
  finish
endif

" Set mappings
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>call compiler#Make('php')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
