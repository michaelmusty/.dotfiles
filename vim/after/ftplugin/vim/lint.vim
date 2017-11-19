" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_vim_lint') || &compatible
  finish
endif
let b:did_ftplugin_vim_lint = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_vim_lint'
endif

" Build function for checker
if !exists('*s:VimLint')
  function s:VimLint()
    let l:save_makeprg = &l:makeprg
    let l:save_errorformat = &l:errorformat
    compiler vint
    lmake!
    let &l:makeprg = l:save_makeprg
    let &l:errorformat = l:save_errorformat
    lwindow
  endfunction
endif

" Set up a mapping for the linter, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_vim_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>VimLint
        \ :<C-U>call <SID>VimLint()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>VimLint'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>VimLint')
    nmap <buffer> <unique>
          \ <LocalLeader>l
          \ <Plug>VimLint
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>l'
    endif
  endif

endif
