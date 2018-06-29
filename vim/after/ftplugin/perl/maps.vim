" perl/maps.vim: tejr's mappings for 'perl' filetypes

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_perl_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_perl_maps = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_perl_maps'

" Set mappings
nmap <buffer> <LocalLeader>c <Plug>PerlCheck
nmap <buffer> <LocalLeader>l <Plug>PerlLint
nmap <buffer> <LocalLeader>t <Plug>PerlTidy
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
      \ . '|nunmap <buffer> <LocalLeader>l'
      \ . '|nunmap <buffer> <LocalLeader>t'
