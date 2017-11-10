"
" user_ftplugin.vim: When switching filetypes, look for a b:undo_user_ftplugin
" variable and use it in much the same way the core's ftplugin.vim does
" b:undo_ftplugin in Vim >= 7.0. This allows you to undo your own ftplugin
" files the same way you can the core ones.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_user_ftplugin')
      \ || !has('autocmd')
      \ || &compatible
  finish
endif
let g:loaded_user_ftplugin = 1

function! s:LoadUserFtplugin()
  if exists('b:undo_user_ftplugin')
    execute b:undo_user_ftplugin
    unlet b:undo_user_ftplugin
  endif
endfunction

augroup user_ftplugin
  autocmd!
  autocmd FileType * call s:LoadUserFtplugin()
augroup END
