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

  " Check this line to see if it's a generic hello-name greeting that we can
  " just strip out; delete the following line too, if it's blank
  if getline('.') =~? '^>\s*\%(<hello\|hi\)\s\+\S\+\s*$'
    delete
    if getline('.') =~# '^>$'
      delete
    endif
  endif

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

" Move through quoted paragraphs like normal-mode `{` and `}`
function! s:NewBlank(start, count, up) abort

  " Flag for whether we've started a block
  let l:block = 0

  " Flag for the number of blocks passed
  let l:blocks = 0

  " Iterate through buffer lines
  let l:num = a:start
  while l:num > 0 && l:num <= line('$')

    " If the line is blank
    if getline(l:num) =~# '^[ >]*$'

      " If we'd moved through a non-blank block already, reset that flag and
      " bump up the block count
      if l:block
        let l:block = 0
        let l:blocks += 1
      endif

      " If we've hit the number of blocks, end the loop
      if l:blocks == a:count
        break
      endif

    " If the line is not blank, flag that we're going through a block
    else
      let l:block = 1
    endif

    " Move the line number or up or down depending on direction
    let l:num += a:up ? -1 : 1
  endwhile

  " Move to line if nonzero and not equal to the current line
  if l:num && l:num != line('.')
    execute 'normal '.l:num.'G'
  endif

endfunction

" Maps using NewBlank() function above for quoted paragraph movement
nnoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call <SID>NewBlank(line('.'), v:count1, 1)<CR>
nnoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call <SID>NewBlank(line('.'), v:count1, 0)<CR>
onoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call <SID>NewBlank(line('.'), v:count1, 1)<CR>
onoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call <SID>NewBlank(line('.'), v:count1, 0)<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>['
      \ . '|nunmap <buffer> <LocalLeader>]'
      \ . '|ounmap <buffer> <LocalLeader>['
      \ . '|ounmap <buffer> <LocalLeader>]'
