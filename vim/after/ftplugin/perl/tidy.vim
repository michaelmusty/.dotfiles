" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_perl_tidy') || &compatible
  finish
endif
let b:did_ftplugin_perl_tidy = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_perl_tidy'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PerlTidy
      \ :<C-U>%!perltidy<CR>
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <Plug>PerlTidy'
endif

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>PerlTidy')
  nmap <buffer> <unique>
        \ <LocalLeader>t
        \ <Plug>PerlTidy
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <LocalLeader>t'
  endif
endif
