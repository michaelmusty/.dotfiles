" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_html_lint') || &compatible
  finish
endif
let b:did_ftplugin_html_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_html_lint'

" Set up a mapping for the linter, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_html_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>HtmlLint
        \ :<C-U>write !tidy -errors -quiet<CR>
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <Plug>HtmlLint'

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>HtmlLint')
    nmap <buffer> <unique>
          \ <LocalLeader>l
          \ <Plug>HtmlLint
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <LocalLeader>l'
  endif

endif
