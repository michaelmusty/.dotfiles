" html/maps.vim: tejr's mappings for 'html' filetypes

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_html_maps')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_html_maps = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_html_maps'

" Set mappings
nmap <buffer> <LocalLeader>l <Plug>HtmlLint
nmap <buffer> <LocalLeader>r <Plug>HtmlUrlLink
nmap <buffer> <LocalLeader>t <Plug>HtmlTidy
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>l'
      \ . '|nunmap <buffer> <LocalLeader>r'
      \ . '|nunmap <buffer> <LocalLeader>t'
