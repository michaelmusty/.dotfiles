" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_perl_check') || &compatible
  finish
endif
let b:did_ftplugin_perl_check = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_perl_check'
endif

" Set up a mapping for the checker, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_perl_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>PerlCheck
        \ :<C-U>write !perl -c<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>PerlCheck'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>PerlCheck')
    nmap <buffer> <unique>
          \ <LocalLeader>c
          \ <Plug>PerlCheck
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>c'
    endif
  endif

endif
