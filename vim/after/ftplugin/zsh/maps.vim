" zsh/maps.zsh: tejr's mappings for 'zsh' filetypes

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_zsh_maps')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_zsh_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_zsh_maps = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_zsh_maps'

" Set mappings
nmap <buffer> <LocalLeader>c <Plug>ZshCheck
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
