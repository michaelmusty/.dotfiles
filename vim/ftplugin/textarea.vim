" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_textarea_maps')
  finish
endif

" Local mapping to switch to mail filetype, just because that's very often the
" contents of text areas I edit using TextEditorAnywhere
nnoremap <buffer> <LocalLeader>f
      \ :<C-U>setlocal filetype=mail<CR>
let b:undo_ftplugin = 'nunmap <buffer> <LocalLeader>f'
