" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_sh_check') || &compatible
  finish
endif
let b:did_ftplugin_sh_check = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_sh_check'
endif

" Choose checker based on shell family
if exists('b:is_bash')
  let b:sh_check_makeprg = 'bash -n %:S'
elseif exists('b:is_kornshell')
  let b:sh_check_makeprg = 'ksh -n %:S'
else
  let b:sh_check_makeprg = 'sh -n %:S'
endif
let b:sh_check_errorformat = '%f: %l: %m'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:sh_check_makeprg'
        \ . '|unlet b:sh_check_errorformat'
endif

" Build function for checker
if !exists('*s:ShCheck')
  function s:ShCheck()
    let l:save_makeprg = &l:makeprg
    let l:save_errorformat = &l:errorformat
    let &l:makeprg = b:sh_check_makeprg
    let &l:errorformat = b:sh_check_errorformat
    lmake!
    let &l:makeprg = l:save_makeprg
    let &l:errorformat = l:save_errorformat
    lwindow
  endfunction
endif

" Set up a mapping for the checker, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_sh_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>ShCheck
        \ :<C-U>call <SID>ShCheck()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>ShCheck'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>ShCheck')
    nmap <buffer> <unique>
          \ <LocalLeader>c
          \ <Plug>ShCheck
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>c'
    endif
  endif

endif
