" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_zsh_check') || &compatible
  finish
endif
let b:did_ftplugin_zsh_check = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_zsh_check'
endif

" Build function for checker
function! s:ZshCheck()
  let l:save_makeprg = &l:makeprg
  let l:save_errorformat = &l:errorformat
  unlet! g:current_compiler
  compiler zsh
  make!
  let &l:makeprg = l:save_makeprg
  let &l:errorformat = l:save_errorformat
  cwindow
endfunction

" Set up a mapping for the checker, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_zsh_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>ZshCheck
        \ :<C-U>call <SID>ZshCheck()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>ZshCheck'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>ZshCheck')
    nmap <buffer> <unique>
          \ <LocalLeader>c
          \ <Plug>ZshCheck
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>c'
    endif
  endif

endif
