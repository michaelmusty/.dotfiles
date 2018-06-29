" make/maps.vim: tejr's mappings for 'make' filetypes

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_make_maps')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_make_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_make_maps = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_make_maps'

" Set mappings
nmap <buffer> <LocalLeader>m <Plug>MakeTarget
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>m'
