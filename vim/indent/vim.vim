" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Ancient Vim can't use the '<' suffix syntax for resetting local integer
" options
if v:version > 700
  let b:undo_user_indent
        \ = 'setlocal shiftwidth< softtabstop< tabstop<'
endif
