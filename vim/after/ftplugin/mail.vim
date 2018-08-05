" Extra configuration for mail messages
if &filetype !=# 'mail' || &compatible || v:version < 700
  finish
endif

" If something hasn't already moved the cursor, we'll move to an optimal point
" to start writing
if line('.') == 1 && col('.') == 1

  " Start by trying to move to the first quoted line; this may fail if there's
  " no quote, which is fine
  call search('\m^>', 'c')

  " Now move to the first quoted or unquoted blank line
  call search('\m^>\=$', 'c')

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
nnoremap <buffer> <expr> <LocalLeader>q quote#Quote()
nnoremap <buffer> <expr> <LocalLeader>qq quote#Quote().'_'
xnoremap <buffer> <expr> <LocalLeader>q quote#Quote()
nnoremap <buffer> <expr> <LocalLeader>Q quote#QuoteReformat()
nnoremap <buffer> <expr> <LocalLeader>QQ quote#QuoteReformat().'_'
xnoremap <buffer> <expr> <LocalLeader>Q quote#QuoteReformat()
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>q'
      \ . '|nunmap <buffer> <LocalLeader>qq'
      \ . '|xunmap <buffer> <LocalLeader>q'
      \ . '|nunmap <buffer> <LocalLeader>Q'
      \ . '|nunmap <buffer> <LocalLeader>QQ'
      \ . '|xunmap <buffer> <LocalLeader>Q'

" Flag a message as unimportant
function! s:FlagUnimportant()
  call cursor(1, 1)
  call search('^$')
  -
  call append(line('.'), 'X-Priority: 5')
  call append(line('.'), 'Importance: Low')
endfunction
nnoremap <buffer>
      \ <LocalLeader>l
      \ <C-U>:call <SID>FlagUnimportant()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>l'
