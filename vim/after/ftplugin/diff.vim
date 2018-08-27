" Extra configuration for diffs
if &filetype !=# 'diff' || v:version < 700 || &compatible
  finish
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_diff_maps')
  finish
endif

" Modify curly braces to navigate by diff block
nnoremap <buffer> <LocalLeader>[
      \ :call search('\m^@@', 'bW')<CR>
nnoremap <buffer> <LocalLeader>]
      \ :call search('\m^@@', 'W')<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>['
      \ . '|nunmap <buffer> <LocalLeader>]'

" Set mappings
nmap <buffer> <LocalLeader>p
      \ <Plug>(DiffPrune)
xmap <buffer> <LocalLeader>p
      \ <Plug>(DiffPrune)
nmap <buffer> <LocalLeader>pp
      \ <Plug>(DiffPrune)_
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>p'
      \ . '|xunmap <buffer> <LocalLeader>p'
      \ . '|nunmap <buffer> <LocalLeader>pp'
