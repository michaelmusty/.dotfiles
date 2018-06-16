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

" Flag as loaded
let b:did_ftplugin_html_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_html_lint'

" Build function for linter
function! s:HtmlLint()
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  compiler tidy
  lmake!
  lwindow
  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  endif
endfunction

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>HtmlLint
      \ :<C-U>call <SID>HtmlLint()<CR>
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
