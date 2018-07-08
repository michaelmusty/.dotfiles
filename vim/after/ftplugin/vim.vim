" Extra configuration for Vim scripts
if &filetype != 'vim' || &compatible || v:version < 700
  finish
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_vim_maps')
  finish
endif

" Set mappings
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>call compiler#Make('vint')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>l'

" Get rid of the core ftplugin's square-bracket maps on unload
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> [['
      \ . '|vunmap <buffer> [['
      \ . '|nunmap <buffer> ]]'
      \ . '|vunmap <buffer> ]]'
      \ . '|nunmap <buffer> []'
      \ . '|vunmap <buffer> []'
      \ . '|nunmap <buffer> ]['
      \ . '|vunmap <buffer> ]['
      \ . '|nunmap <buffer> ]"'
      \ . '|vunmap <buffer> ]"'
      \ . '|nunmap <buffer> ["'
      \ . '|vunmap <buffer> ["'
