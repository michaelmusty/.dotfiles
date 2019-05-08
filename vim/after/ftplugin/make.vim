" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_make_maps')
  finish
endif

" Set mappings
nmap <buffer> <LocalLeader>m <Plug>(MakeTarget)
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>m'
