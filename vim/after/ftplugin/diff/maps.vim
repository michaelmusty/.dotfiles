" diff/maps.vim: tejr's mappings for 'diff' filetypes

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_diff_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_diff_maps = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_diff_maps'

" Set mappings
nmap <buffer> <LocalLeader>p <Plug>DiffPrune
xmap <buffer> <LocalLeader>p <Plug>DiffPrune
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>p'
      \ . '|xunmap <buffer> <LocalLeader>p'
