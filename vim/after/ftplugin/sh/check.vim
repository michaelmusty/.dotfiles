" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_sh_check') || &compatible
  finish
endif
let b:did_ftplugin_sh_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_sh_check'

" Choose checker based on shell family
if exists('b:is_bash')
  let b:sh_check = 'write !bash -n'
elseif exists('b:is_kornshell')
  let b:sh_check = 'write !ksh -n'
else
  let b:sh_check = 'write !sh -n'
endif
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:sh_check'

" Set up a mapping for the checker, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_sh_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>ShCheck
        \ :<C-U>execute b:sh_check<CR>
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <Plug>ShCheck'

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>ShCheck')
    nmap <buffer> <unique>
          \ <LocalLeader>c
          \ <Plug>ShCheck
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <LocalLeader>c'
  endif

endif
