" Extra configuration for Makefiles
if &filetype != 'make' || &compatible || v:version < 700
  finish
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_make_maps')
  finish
endif

" Set mappings
if exists('b:undo_ftplugin')
  nmap <buffer> <LocalLeader>m <Plug>MakeTarget
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>m'
endif
