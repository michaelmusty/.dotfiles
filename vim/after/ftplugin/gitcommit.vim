" Extra configuration for Git commit messages
if &filetype !=# 'gitcommit' || v:version < 700
  finish
endif

" Make angle brackets behave like mail quotes
setlocal comments+=n:>
setlocal formatoptions+=coqr
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_gitcommit_maps')
  finish
endif

" Mail quote mappings
nnoremap <buffer> <expr> <LocalLeader>q quote#Quote()
nnoremap <buffer> <expr> <LocalLeader>qq quote#Quote().'_'
xnoremap <buffer> <expr> <LocalLeader>q quote#Quote()
let b:undo_ftplugin .= '|nunmap <LocalLeader>q'
      \ . '|nunmap <LocalLeader>qq'
      \ . '|xunmap <LocalLeader>q'
