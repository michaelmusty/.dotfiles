" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_sh_lint') || &compatible
  finish
endif
let b:did_ftplugin_sh_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_sh_lint'

" Choose linter based on shell family
if exists('b:is_bash')
  let b:sh_lint = 'write !shellcheck -e SC1090 -s bash -'
elseif exists('b:is_kornshell')
  let b:sh_lint = 'write !shellcheck -e SC1090 -s ksh -'
else
  let b:sh_lint = 'write !shellcheck -e SC1090 -s sh -'
endif
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:sh_lint'

" Set up a mapping for the linter, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_sh_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>ShLint
        \ :<C-U>execute b:sh_lint<CR>
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <Plug>ShLint'

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>ShLint')
    nmap <buffer> <unique>
          \ <LocalLeader>l
          \ <Plug>ShLint
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <LocalLeader>l'
  endif

endif
