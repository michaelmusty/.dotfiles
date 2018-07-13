" Extra configuration for mail messages
if &filetype !=# 'mail' || &compatible || v:version < 700
  finish
endif

" We will almost always want to start editing after the headers, so move to
" the first entirely blank line, if something hasn't already moved us from the
" start of the file
if line('.') == 1 && col('.') == 1
  call search('^$', 'c')
endif

" Add a space to the end of wrapped lines for format-flowed mail
setlocal formatoptions+=w
let b:undo_ftplugin .= '|setlocal formatoptions<'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_mail_maps')
  finish
endif

" The quote mapping in the stock plugin is a good idea, but I prefer it to
" work as a motion rather than quoting to the end of the buffer
nnoremap <buffer> <expr> <LocalLeader>q mail#Quote()
nnoremap <buffer> <expr> <LocalLeader>qq mail#Quote().'_'
xnoremap <buffer> <expr> <LocalLeader>q mail#Quote()
let b:undo_ftplugin .= '|nunmap <LocalLeader>q'
      \ . '|nunmap <LocalLeader>qq'
      \ . '|xunmap <LocalLeader>q'
