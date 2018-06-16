" zsh/check.vim: Use Z shell binary to check for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_zsh_check')
  finish
endif

" Flag as loaded
let b:did_ftplugin_zsh_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_zsh_check'

" Build function for checker
function! s:ZshCheck()
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  compiler zsh
  lmake!
  lwindow
  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  endif
endfunction

" Set up a mapping for the checker, if we're allowed
if exists('g:no_plugin_maps') || exists('g:no_zsh_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>ZshCheck
      \ :<C-U>call <SID>ZshCheck()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>ZshCheck'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>ZshCheck')
  nmap <buffer> <unique>
        \ <LocalLeader>c
        \ <Plug>ZshCheck
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>c'
endif
