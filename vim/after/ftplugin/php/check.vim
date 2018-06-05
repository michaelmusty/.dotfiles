" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_php_check') || &compatible
  finish
endif
let b:did_ftplugin_php_check = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_php_check'
endif

" Build function for checker
if !exists('*s:PhpCheck')
  function s:PhpCheck()
    let l:save_makeprg = &l:makeprg
    let l:save_errorformat = &l:errorformat
    unlet! g:current_compiler
    compiler php

    " 7.4.191 is the earliest version with the :S file name modifier, which we
    " really should use if we can
    if v:version >= 704 || v:version == 704 && has('patch191')
      make! %:S
    else
      make! %
    endif

    let &l:makeprg = l:save_makeprg
    let &l:errorformat = l:save_errorformat
    cwindow
  endfunction
endif

" Set up a mapping for the checker, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_php_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>PhpCheck
        \ :<C-U>call <SID>PhpCheck()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>PhpCheck'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>PhpCheck')
    nmap <buffer> <unique>
          \ <LocalLeader>c
          \ <Plug>PhpCheck
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>c'
    endif
  endif

endif
