" Extra configuration for 'diff' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'diff'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_diff_maps')
  finish
endif

" Set mappings
nmap <buffer> <LocalLeader>p <Plug>(DiffPrune)
xmap <buffer> <LocalLeader>p <Plug>(DiffPrune)
nmap <buffer> <LocalLeader>pp <Plug>(DiffPrune)_
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>p'
      \ . '|xunmap <buffer> <LocalLeader>p'
      \ . '|nunmap <buffer> <LocalLeader>pp'
