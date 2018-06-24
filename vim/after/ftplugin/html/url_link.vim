" html/url_link.vim: Make a URL into a link

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_html_url_link')
  finish
endif

" Don't load if the primary filetype isn't HTML
if &filetype !=# 'html'
  finish
endif

" Flag as loaded
let b:did_ftplugin_html_url_link = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_html_url_link'

" Make a bare URL into a link to itself
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

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>HtmlUrlLink
      \ :<C-U>call <SID>HtmlUrlLink()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>HtmlUrlLink'
