" vim/clear_maps.vim: Fix clearing buffer-local vim maps that the core
" ftplugin leaves in place

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_vim_lint')
  finish
endif

" Don't load if the mappings probably weren't loaded in the first place
if exists('g:no_plugin_maps') || exists('g:no_vim_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_vim_clear_maps = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_vim_clear_maps'

" Add undo commands
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|silent! nunmap <buffer> [['
      \ . '|silent! vunmap <buffer> [['
      \ . '|silent! nunmap <buffer> ]]'
      \ . '|silent! vunmap <buffer> ]]'
      \ . '|silent! nunmap <buffer> []'
      \ . '|silent! vunmap <buffer> []'
      \ . '|silent! nunmap <buffer> ]['
      \ . '|silent! vunmap <buffer> ]['
      \ . '|silent! nunmap <buffer> ]"'
      \ . '|silent! vunmap <buffer> ]"'
      \ . '|silent! nunmap <buffer> ["'
      \ . '|silent! vunmap <buffer> ["'
