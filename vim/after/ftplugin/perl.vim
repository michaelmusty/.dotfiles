" Extra configuration for Perl filetypes
if &filetype != 'perl' || &compatible || v:version < 700
  finish
endif

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
nmap <buffer> <LocalLeader>v
      \ <Plug>PerlVersionBumpMinor
nmap <buffer> <LocalLeader>V
      \ <Plug>PerlVersionBumpMajor
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>v'
      \ . '|nunmap <buffer> <LocalLeader>V'
