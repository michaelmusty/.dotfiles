" vim/lint.vim: Use Vint to lint VimL scripts

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_vim_lint')
  finish
endif

" Flag as loaded
let b:did_ftplugin_vim_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_vim_lint'

" Build function for linter
function! s:VimLint()
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  compiler vint
  lmake!
  lwindow
  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  endif
endfunction

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_vim_maps')
  finish
endif

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>VimLint
      \ :<C-U>call <SID>VimLint()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>VimLint'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>VimLint')
  nmap <buffer> <unique>
        \ <LocalLeader>l
        \ <Plug>VimLint
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>l'
endif
