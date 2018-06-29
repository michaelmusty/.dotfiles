" c/include.vim: Set 'include' and 'path'

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_cpp_include')
  finish
endif

" Flag as loaded
let b:did_ftplugin_cpp_include = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_cpp_include'

" Use trailing whitespace to denote continued paragraph
setlocal include=^\\s*#\\s*include
setlocal path+=/usr/include
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal include< path<'
