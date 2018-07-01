" Extra configuration for 'html' filetypes
if exists('b:did_ftplugin_after') || &compatible
  finish
endif
if v:version < 700
  finish
endif
if &filetype !=# 'html'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Set up hooks for timestamp updating
augroup html_timestamp
  autocmd!
  autocmd BufWritePre *.html
        \ if exists('b:html_timestamp_check')
        \|  call html#TimestampUpdate()
        \|endif
augroup END
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|augroup html_timestamp|autocmd!|augroup END'
      \ . '|augroup! html_timestamp'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Set mappings
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>call compiler#Make('tidy')<CR>
nnoremap <buffer> <LocalLeader>r
      \ :<C-U>call html#UrlLink()<CR>
nnoremap <buffer> <LocalLeader>t
      \ :<C-U>call filter#Stable('tidy -quiet')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>l'
      \ . '|nunmap <buffer> <LocalLeader>r'
      \ . '|nunmap <buffer> <LocalLeader>t'
