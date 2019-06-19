" Only do this when not yet done for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" Set comment formats
setlocal comments=:#
setlocal formatoptions+=or
let b:undo_ftplugin = 'setlocal comments< formatoptions<'

" Fold based on indent level, but start with all folds open
setlocal foldmethod=indent
setlocal foldlevel=99
let b:undo_ftplugin .= '|setlocal foldmethod< foldlevel<'

" Specify ERE flavor for regex_escape.vim
let b:regex_escape_flavor = 'ere'
let b:undo_ftplugin .= '|unlet b:regex_escape_flavor'
