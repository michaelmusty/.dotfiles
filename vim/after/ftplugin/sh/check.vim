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
  let b:sh_check = 'write !bash -n'
elseif exists('b:is_kornshell')
  let b:sh_check = 'write !ksh -n'
else
  let b:sh_check = 'write !sh -n'
endif
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:sh_check'
endif

" Set up a mapping for the checker, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_sh_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>ShCheck
        \ :<C-U>execute b:sh_check<CR>
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
