" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled, or if no autocmd feature, or if Vim
" is too old to support the needed autocmd events
if exists('b:did_ftplugin_markdown_autoformat') || &compatible
  finish
endif
if !has('autocmd') || v:version < 700
  finish
endif
let b:did_ftplugin_markdown_autoformat = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_markdown_autoformat'
endif

" Turn on autoformatting if the buffer has no code-block lines with spaces
" that is longer than 'textwidth'
call ftplugin#markdown#autoformat#Load()

" Group autocommands
augroup ftplugin_markdown_autoformat
  autocmd!

  " Suspend auto-formatting when in a code block (four-space indent)
  autocmd BufWinEnter,CursorMoved,CursorMovedI,WinEnter
        \ <buffer>
        \ call ftplugin#markdown#autoformat#Line()

augroup END

" Suspend auto-format when pasting anything with a linebreak
nnoremap <buffer> <silent>
      \ p
      \ :<C-u>call ftplugin#markdown#autoformat#PutBelow()<CR>
nnoremap <buffer> <silent>
      \ P
      \ :<C-u>call ftplugin#markdown#autoformat#PutAbove()<CR>

" Undo all the above
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal formatoptions<'
        \ . '|augroup ftplugin_markdown_autoformat'
        \ . '|autocmd!'
        \ . '|augroup END'
endif
