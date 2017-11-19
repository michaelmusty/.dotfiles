" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled
if exists('b:did_ftplugin_sh_lint') || &compatible
  finish
endif
let b:did_ftplugin_sh_lint = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_sh_lint'
endif

" Choose linter based on shell family
if exists('b:is_bash')
  let b:sh_lint_makeprg = 'shellcheck -e SC1090 -f gcc -s bash %:S'
elseif exists('b:is_kornshell')
  let b:sh_lint_makeprg = 'shellcheck -e SC1090 -f gcc -s ksh %:S'
else
  let b:sh_lint_makeprg = 'shellcheck -e SC1090 -f gcc -s sh %:S'
endif
let b:sh_lint_errorformat = '%f:%l:%c: %m [SC%n]'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:sh_lint_makeprg'
        \ . '|unlet b:sh_lint_errorformat'
endif

" Build function for checker
if !exists('*s:ShLint')
  function s:ShLint()
    let l:save_makeprg = &l:makeprg
    let l:save_errorformat = &l:errorformat
    let &l:makeprg = b:sh_lint_makeprg
    let &l:errorformat = b:sh_lint_errorformat
    lmake!
    let &l:makeprg = l:save_makeprg
    let &l:errorformat = l:save_errorformat
    lwindow
  endfunction
endif

" Set up a mapping for the linter, if we're allowed
if !exists('g:no_plugin_maps') && !exists('g:no_sh_maps')

  " Define a mapping target
  nnoremap <buffer> <silent> <unique>
        \ <Plug>ShLint
        \ :<C-U>call <SID>ShLint()<CR>
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin = b:undo_ftplugin
          \ . '|nunmap <buffer> <Plug>ShLint'
  endif

  " If there isn't a key mapping already, use a default one
  if !hasmapto('<Plug>ShLint')
    nmap <buffer> <unique>
          \ <LocalLeader>l
          \ <Plug>ShLint
    if exists('b:undo_ftplugin')
      let b:undo_ftplugin = b:undo_ftplugin
            \ . '|nunmap <buffer> <LocalLeader>l'
    endif
  endif

endif
