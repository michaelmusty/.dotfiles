" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled, or if no autocmd feature, or if Vim
" is too old to support the needed autocmd events
if exists('b:did_ftplugin_markdown_suspend_autoformat') || &compatible
  finish
endif
if !has('autocmd') || v:version < 700
  finish
endif
let b:did_ftplugin_markdown_suspend_autoformat = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_markdown_suspend_autoformat'
endif

" When editing a code block, quietly remove auto 'a' from 'formatoptions' if
" present, flagging that we've done so; restore it once we move away.
autocmd BufWinEnter,CursorMoved,CursorMovedI,WinEnter
      \ <buffer>
      \   if getline('.') =~# '\m^    '
      \ |   if &formatoptions =~# '\ma'
      \ |     setlocal formatoptions-=a
      \ |     let b:markdown_suspend_autoformat_suspended = 1
      \ |   endif
      \ | elseif exists('b:markdown_suspend_autoformat_suspended')
      \ |   setlocal formatoptions+=a
      \ |   unlet b:markdown_suspend_autoformat_suspended
      \ | endif

" Undo all the above
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal formatoptions<'
endif
