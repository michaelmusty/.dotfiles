" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_perl_check') || &compatible
  finish
endif
let b:did_ftplugin_perl_check = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_perl_check'
endif

" Build function for checker
function! s:PerlCheck()
  let l:save_makeprg = &l:makeprg
  let l:save_errorformat = &l:errorformat
  unlet! g:current_compiler
  compiler perl
  make!
  let &l:makeprg = l:save_makeprg
  let &l:errorformat = l:save_errorformat
  cwindow
endfunction

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PerlCheck
      \ :<C-U>call <SID>PerlCheck()<CR>
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <Plug>PerlCheck'
endif

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>PerlCheck')
  nmap <buffer> <unique>
        \ <LocalLeader>c
        \ <Plug>PerlCheck
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <LocalLeader>c'
  endif
endif
