" vim/maps.vim: tejr's mappings for 'vim' filetypes

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_vim_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_vim_maps = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_vim_maps'

" Set mappings
nmap <buffer> <LocalLeader>l <Plug>VimLint
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>l'

" Add undo commands to fix clearing buffer-local vim maps that the core
" ftplugin leaves in place
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
