" Extra configuration for Vim scripts
if &filetype !=# 'vim' || v:version < 700 || &compatible
  finish
endif

" Use Vint as a syntax checker
compiler vint
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal errorformat< makeprg'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_vim_maps')
  finish
endif

" Get rid of the core ftplugin's square-bracket maps on unload
let b:undo_ftplugin .= '|nunmap <buffer> [['
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
