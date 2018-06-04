" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled, or if the current filetype is
" actually markdown
if exists('b:did_ftplugin_html_tidy') || &compatible
  finish
endif
if &filetype == 'markdown'
  finish
endif
let b:did_ftplugin_html_tidy = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_html_tidy'
endif

" Set up a mapping for the tidier, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_html_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>HtmlTidy
        \ :<C-U>%!tidy -quiet<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>HtmlTidy'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>HtmlTidy')
    nmap <buffer> <unique>
          \ <LocalLeader>t
          \ <Plug>HtmlTidy
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>t'
    endif
  endif

endif
