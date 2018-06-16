" perl/lint.vim: Use Perl::Critic to lint scripts

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_perl_lint')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_perl_lint = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_perl_lint'

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PerlLint
      \ :<C-U>call compiler#Make('perlcritic')<CR>
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
