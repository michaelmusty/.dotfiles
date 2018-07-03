" Extra configuration for 'perl' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
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
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>call compiler#Make('perl')<CR>
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>call compiler#Make('perlcritic')<CR>
nnoremap <buffer> <LocalLeader>t
      \ :<C-U>call filter#Stable('perltidy')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'
      \ . '|nunmap <buffer> <LocalLeader>t'

" Bump version numbers
nnoremap <buffer> <LocalLeader>v
      \ :<C-U>call perl#BumpVersionMinor()<CR>
nnoremap <buffer> <LocalLeader>V
      \ :<C-U>call perl#BumpVersionMajor()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>v'
      \ . '|nunmap <buffer> <LocalLeader>V'
