" perl/lint.vim: Use Perl::Critic to lint scripts

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_perl_lint')
  finish
endif

" Flag as loaded
let b:did_ftplugin_perl_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_perl_lint'

" Build function for linter
function! s:PerlLint()
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  compiler perlcritic
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
      \ <Plug>PerlLint
      \ :<C-U>call <SID>PerlLint()<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>PerlLint'

" If there isn't a key mapping already, use a default one
if !hasmapto('<Plug>PerlLint')
  nmap <buffer> <unique>
        \ <LocalLeader>l
        \ <Plug>PerlLint
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|nunmap <buffer> <LocalLeader>l'
endif
