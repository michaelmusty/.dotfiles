" Observe VimL conventions for two-space indents
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Unload this indent plugin; suppress errors because ancient Vim can't use the
" '<' suffix syntax for resetting local integer
let b:undo_user_indent
      \ = 'silent! setlocal shiftwidth< softtabstop< tabstop<'
