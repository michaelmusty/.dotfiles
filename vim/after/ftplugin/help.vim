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

" Use :help as 'keywordprg' if not already set; this is the default since Vim
" v8.1.0690
if &keywordprg !=# ':help'
  setlocal keywordprg=:help
  let b:undo_ftplugin .= '|setlocal keywordprg<'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_help_maps')
  finish
endif

" ,K runs :helpgrep on the word under the cursor
nnoremap <buffer> <LocalLeader>K
      \ :<C-U>helpgrep <cword><CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>K'
