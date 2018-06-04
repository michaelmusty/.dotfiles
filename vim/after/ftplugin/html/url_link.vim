" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled, or if the current filetype is
" actually markdown
if exists('b:did_ftplugin_html_url_link') || &compatible
  finish
endif
if &filetype == 'markdown'
  finish
endif
let b:did_ftplugin_html_url_link = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_html_url_link'
endif

" Make a bare URL into a link to itself
if !exists('*s:HtmlUrlLink')
  function! s:HtmlUrlLink()

    " Yank this whole whitespace-separated word
    normal! yiW
    " Open a link tag
    normal! i<a href="">
    " Paste the URL into the quotes
    normal! hP
    " Move to the end of the link text URL
    normal! E
    " Close the link tag
    normal! a</a>

  endfunction
endif

" Set up a mapping for the function, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_html_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>HtmlUrlLink
        \ :<C-U>call <SID>HtmlUrlLink()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>HtmlUrlLink'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>HtmlUrlLink')
    nmap <buffer> <unique>
          \ <LocalLeader>r
          \ <Plug>HtmlUrlLink
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>r'
    endif
  endif

endif
