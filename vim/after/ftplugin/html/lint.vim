" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_html_lint') || &compatible
  finish
endif
let b:did_ftplugin_html_lint = 1

" Initialise undo variable if not already done
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_html_lint'
endif

" Build function for linter
if !exists('*s:HtmlLint')
  function s:HtmlLint()
    let l:save_makeprg = &l:makeprg
    let l:save_errorformat = &l:errorformat
    compiler tidy
    make!
    let &l:makeprg = l:save_makeprg
    let &l:errorformat = l:save_errorformat
    cwindow
  endfunction
endif

" Set up a mapping for the linter, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_html_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>HtmlLint
        \ :<C-U>call <SID>HtmlLint()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>HtmlLint'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>HtmlLint')
    nmap <buffer> <unique>
          \ <LocalLeader>l
          \ <Plug>HtmlLint
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>l'
    endif
  endif

endif
