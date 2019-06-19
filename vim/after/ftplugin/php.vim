" Use PHP itself for syntax checking
compiler php
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal errorformat< makeprg<'

" Set comment formats
setlocal comments=s1:/*,m:*,ex:*/,://,:#
setlocal formatoptions+=or
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'

" Fold based on indent level
setlocal foldmethod=indent
let b:undo_ftplugin .= '|setlocal foldmethod<'

" Use pman as 'keywordprg'
setlocal keywordprg=pman
let b:undo_ftplugin .= '|setlocal keywordprg<'

" Specify ERE regex (close to PCRE) for regex_escape.vim
let b:regex_escape_flavor = 'ere'
let b:undo_ftplugin .= '|unlet b:regex_escape_flavor'

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_php_maps')
  finish
endif

" Switch to HTML filetype for templated PHP
nnoremap <buffer> <LocalLeader>f
      \ :<C-U>setlocal filetype=html<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>f'
