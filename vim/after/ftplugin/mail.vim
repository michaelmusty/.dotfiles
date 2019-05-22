" If something hasn't already moved the cursor, we'll move to an optimal point
" to start writing
if line('.') == 1 && col('.') == 1

  " Start by trying to move to the first quoted line; this may fail if there's
  " no quote, which is fine
  call search('\m^>', 'c')

  " Check this line to see if it's a generic hello or hello-name greeting that
  " we can just strip out; delete any following lines too, if they're blank
  if getline('.') =~? '^>\s*\%(<hello\|hey\+\|hi\)\(\s\+\S\+\)\=[,;]*\s*$'
    delete
    while getline('.') =~# '^>\s*$'
      delete
    endwhile
  endif

  " Now move to the first quoted or unquoted blank line
  call search('\m^>\=$', 'c')

endif

" Normalise quoting
for lnum in range(1, line('$'))

  " Get current line
  let line = getline(lnum)

  " Get the leading quote string, if any; stop if there isn't one
  let quote = matchstr(line, '^[> \t]\+')
  if strlen(quote) == 0
    return
  endif

  " Normalise the quote with no intermediate and one trailing space
  let quote = substitute(quote, '[^>]', '', 'g').' '

  " Re-set the line
  let line = substitute(line, '^[> \t]\+', quote, '')
  call setline(lnum, line)

endfor

" Add a space to the end of wrapped lines for format-flowed mail
setlocal formatoptions+=w
let b:undo_ftplugin .= '|setlocal formatoptions<'

" Define what constitutes a 'blank line' for the squeeze_repeat_blanks.vim
" plugin, if loaded, to include leading quotes and spaces
if exists('loaded_squeeze_repeat_blanks')
  let b:squeeze_repeat_blanks_blank = '^[ >]*$'
  let b:undo_ftplugin .= '|unlet b:squeeze_repeat_blanks_blank'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_mail_maps')
  finish
endif

" Flag messages as important/unimportant
nnoremap <buffer> <LocalLeader>h
      \ :<C-U>call mail#FlagImportant()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>h'
nnoremap <buffer> <LocalLeader>l
      \ :<C-U>call mail#FlagUnimportant()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>l'

" Quote operator
nnoremap <buffer> <expr> <LocalLeader>q
      \ quote#Quote()
xnoremap <buffer> <expr> <LocalLeader>q
      \ quote#Quote()
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>q'
      \ . '|xunmap <buffer> <LocalLeader>q'

" Quote operator with reformatting
nnoremap <buffer> <expr> <LocalLeader>Q
      \ quote#QuoteReformat()
xnoremap <buffer> <expr> <LocalLeader>Q
      \ quote#QuoteReformat()
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>Q'
      \ . '|xunmap <buffer> <LocalLeader>Q'

" Maps using autoloaded function for quoted paragraph movement
nnoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call mail#NewBlank(v:count1, 1, 0)<CR>
nnoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call mail#NewBlank(v:count1, 0, 0)<CR>
onoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call mail#NewBlank(v:count1, 1, 0)<CR>
onoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call mail#NewBlank(v:count1, 0, 0)<CR>
xnoremap <buffer> <silent> <LocalLeader>[
      \ :<C-U>call mail#NewBlank(v:count1, 1, 1)<CR>
xnoremap <buffer> <silent> <LocalLeader>]
      \ :<C-U>call mail#NewBlank(v:count1, 0, 1)<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>['
      \ . '|nunmap <buffer> <LocalLeader>]'
      \ . '|ounmap <buffer> <LocalLeader>['
      \ . '|ounmap <buffer> <LocalLeader>]'
      \ . '|xunmap <buffer> <LocalLeader>['
      \ . '|xunmap <buffer> <LocalLeader>]'
