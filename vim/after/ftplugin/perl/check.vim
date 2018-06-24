" perl/check.vim: Use Perl binary to check for errors

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_perl_check')
  finish
endif

" Don't load if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_perl_maps')
  finish
endif

" Flag as loaded
let b:did_ftplugin_perl_check = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_perl_check'

" Define a mapping target
nnoremap <buffer> <silent> <unique>
      \ <Plug>PerlCheck
      \ :<C-U>call compiler#Make('perl')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <Plug>PerlCheck'
