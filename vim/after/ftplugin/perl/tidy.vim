" perl/tidy.vim: Use Perl::Tidy to format and filter scripts

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_perl_tidy')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_perl_tidy = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_perl_tidy'

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PerlTidy
      \ :<C-U>call filter#Stable('perltidy')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>PerlTidy'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>PerlTidy')
  nmap <buffer> <unique>
        \ <LocalLeader>t
        \ <Plug>PerlTidy
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>t'
endif
