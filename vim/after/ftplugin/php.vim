" Use PHP itself for syntax checking
compiler php
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal errorformat< makeprg<'
if executable('php-cs-fixer')
  setlocal equalprg=phpcsff
  let b:undo_ftplugin .= '|setlocal equalprg<'
endif

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

" Set HTML as an alternative filetype
if !exists('b:alternate_filetypes')
  let b:alternate_filetypes = [&filetype, 'html']
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_php_maps')
  finish
endif

" Mappings to choose 'equalprg'
nnoremap <buffer> <LocalLeader>f
      \ :<C-U>setlocal equalprg=phpcsff<CR>
nnoremap <buffer> <LocalLeader>i
      \ :<C-U>setlocal equalprg<<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>f'
      \ . '|nunmap <buffer> <LocalLeader>i'
