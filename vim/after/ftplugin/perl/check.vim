" perl/check.vim: Use Perl binary to check for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_perl_check')
  finish
endif

" Flag as loaded
let b:did_ftplugin_perl_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_perl_check'

" Build function for checker
function! s:PerlCheck()
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  compiler perl
  lmake!
  lwindow
  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  endif
endfunction

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PerlCheck
      \ :<C-U>call <SID>PerlCheck()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>PerlCheck'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>PerlCheck')
  nmap <buffer> <unique>
        \ <LocalLeader>c
        \ <Plug>PerlCheck
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>c'
endif
