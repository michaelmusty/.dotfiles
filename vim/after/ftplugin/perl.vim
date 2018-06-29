" Extra configuration for 'perl' filetypes
if &compatible || v:version < 700 || exists('b:did_ftplugin_after')
  finish
endif
if &filetype !=# 'perl'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Set mappings
nmap <buffer> <LocalLeader>c :<C-U>call compiler#Make('perl')<CR>
nmap <buffer> <LocalLeader>l :<C-U>call compiler#Make('perlcritic')<CR>
nmap <buffer> <LocalLeader>t :<C-U>call filter#Stable('perltidy')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'
      \ . '|nunmap <buffer> <LocalLeader>t'
