" html/tidy.vim: Use tidy(1) to filter HTML documents

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_html_tidy')
  finish
endif

" Don't load if the primary filetype isn't HTML
if &filetype !=# 'html'
  finish
endif

" Flag as loaded
let b:did_ftplugin_html_tidy = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_html_tidy'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>HtmlTidy
      \ :<C-U>%!tidy -quiet<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>HtmlTidy'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>HtmlTidy')
  nmap <buffer> <unique>
        \ <LocalLeader>t
        \ <Plug>HtmlTidy
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>t'
endif
