" html/lint.vim: Use tidy(1) to lint HTML documents for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_html_lint')
  finish
endif

" Don't load if the primary filetype isn't HTML
if &filetype !=# 'html'
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_html_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_html_lint'

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>HtmlLint
      \ :<C-U>call compiler#Make('tidy')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>HtmlLint'
