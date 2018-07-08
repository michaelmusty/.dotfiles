" Extra configuration for HTML files
if &filetype != 'html' || &compatible || v:version < 700
  finish
endif

" Set up hooks for timestamp updating
autocmd html_timestamp BufWritePre <buffer>
      \ if exists('b:html_timestamp_check')
      \|  call html#TimestampUpdate()
      \|endif
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|autocmd! html_timestamp BufWritePre <buffer>'

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
