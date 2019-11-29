" Use PHP itself for syntax checking
compiler php
setlocal equalprg=phpcsff
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal equalprg< errorformat< makeprg<'

" Set comment formats
setlocal comments=s1:/*,m:*,ex:*/,://,:#
setlocal formatoptions+=or
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'

" Fold based on indent level, but start with all folds open
setlocal foldmethod=indent
setlocal foldlevel=99
let b:undo_ftplugin .= '|setlocal foldmethod< foldlevel<'

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
