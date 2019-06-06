" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_diff_maps')
  finish
endif

" Maps using autoloaded function for quoted block movement
noremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call diff#MoveBlock(v:count1, 1, 0)<CR>
sunmap <buffer> <LocalLeader>[
noremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call diff#MoveBlock(v:count1, 0, 0)<CR>
sunmap <buffer> <LocalLeader>]
let b:undo_ftplugin .= '|smap <buffer> <LocalLeader>] <nop>'
      \ . '|unmap <buffer> <LocalLeader>]'
      \ . '|smap <buffer> <LocalLeader>] <nop>'
      \ . '|unmap <buffer> <LocalLeader>]'

" Set mappings for diff pruning plugin
nmap <buffer> <LocalLeader>p
      \ <Plug>(DiffPrune)
xmap <buffer> <LocalLeader>p
      \ <Plug>(DiffPrune)
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>p'
      \ . '|xunmap <buffer> <LocalLeader>p'
