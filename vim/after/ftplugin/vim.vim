" Extra configuration for 'vim' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'vim'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_vim_maps')
  finish
endif

" Set mappings
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>call compiler#Make('vint')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>l'

" Add undo commands to fix clearing buffer-local vim maps that the core
" ftplugin leaves in place
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
