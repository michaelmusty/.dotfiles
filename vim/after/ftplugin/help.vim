" This variable had the wrong name before Vim 7.1
if v:version == 700 && exists('b:undo_plugin')
  let b:undo_ftplugin = b:undo_plugin
  unlet b:undo_plugin
endif

" If the buffer is modifiable and writable, we're writing documentation, not
" reading it; don't conceal characters
if has('conceal') && &modifiable && !&readonly
  setlocal conceallevel=0
  let b:undo_ftplugin .= '|setlocal conceallevel<'
endif

" Use :help for 'keywordprg'; odd that this isn't the default
setlocal keywordprg=:help
let b:undo_ftplugin .= '|setlocal keywordprg<'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_help_maps')
  finish
endif

" ,K runs :helpgrep on the word under the cursor
nnoremap <buffer> <LocalLeader>K
      \ :<C-U>helpgrep <cword><CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>K'
