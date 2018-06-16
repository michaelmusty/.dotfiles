" sh/lint.vim: Use appropriate shell binary to lint scripts for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_sh_lint')
  finish
endif

" Flag as loaded
let b:did_ftplugin_sh_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_sh_lint'

" Build function for linter
function! s:ShLint()
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  compiler shellcheck
  lmake!
  lwindow
  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  endif
endfunction

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_sh_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>ShLint
      \ :<C-U>call <SID>ShLint()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>ShLint'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>ShLint')
  nmap <buffer> <unique>
        \ <LocalLeader>l
        \ <Plug>ShLint
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>l'
endif
