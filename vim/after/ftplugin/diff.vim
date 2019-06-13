" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_diff_maps')
  finish
endif

" Maps using autoloaded function for quoted block movement
nnoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call diff#MoveBlock(v:count1, 1, 0)<CR>
nnoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call diff#MoveBlock(v:count1, 0, 0)<CR>
onoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call diff#MoveBlock(v:count1, 1, 0)<CR>
onoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call diff#MoveBlock(v:count1, 0, 0)<CR>
xnoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call diff#MoveBlock(v:count1, 1, 1)<CR>
xnoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call diff#MoveBlock(v:count1, 0, 1)<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>['
      \ . '|nunmap <buffer> <LocalLeader>]'
      \ . '|ounmap <buffer> <LocalLeader>['
      \ . '|ounmap <buffer> <LocalLeader>]'
      \ . '|xunmap <buffer> <LocalLeader>['
      \ . '|xunmap <buffer> <LocalLeader>]'

" Set mappings for diff pruning plugin
nmap <buffer> <LocalLeader>p
      \ <Plug>(DiffPrune)
xmap <buffer> <LocalLeader>p
      \ <Plug>(DiffPrune)
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>p'
      \ . '|xunmap <buffer> <LocalLeader>p'
