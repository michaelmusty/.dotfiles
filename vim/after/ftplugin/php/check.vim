" php/check.vim: Use PHP binary to check scripts for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_php_check')
  finish
endif

" Flag as loaded
let b:did_ftplugin_php_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_php_check'

" Build function for checker
function! s:PhpCheck()
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  compiler php

  " The PHP compiler is unusual: it gets us to provide the filename argument
  " ourselves. 7.4.191 is the earliest version with the :S file name modifier,
  " which we really should use if we can
  if v:version >= 704 || v:version == 704 && has('patch191')
    lmake! %:S
  else
    lmake! %
  endif
  lwindow

  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  endif
endfunction

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_php_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PhpCheck
      \ :<C-U>call <SID>PhpCheck()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>PhpCheck'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>PhpCheck')
  nmap <buffer> <unique>
        \ <LocalLeader>c
        \ <Plug>PhpCheck
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>c'
endif
