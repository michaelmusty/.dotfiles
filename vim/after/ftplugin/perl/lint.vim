" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_perl_lint') || &compatible
  finish
endif
let b:did_ftplugin_perl_lint = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_perl_lint'
endif

" Build function for linter
if !exists('*s:PerlLint')
  function s:PerlLint()
    let l:save_makeprg = &l:makeprg
    let l:save_errorformat = &l:errorformat
    compiler perlcritic
    make!
    let &l:makeprg = l:save_makeprg
    let &l:errorformat = l:save_errorformat
    cwindow
  endfunction
endif

" Set up a mapping for the linter, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_perl_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>PerlLint
        \ :<C-U>call <SID>PerlLint()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>PerlLint'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>PerlLint')
    nmap <buffer> <unique>
          \ <LocalLeader>l
          \ <Plug>PerlLint
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>l'
    endif
  endif

endif
