" Don't append spaces after quote chars, for strict compliance with
" format=flowed
let b:quote_space = 0

" If something hasn't already moved the cursor, we'll move to an optimal point
" to start writing
if line('.') == 1 && col('.') == 1

  " Start by trying to move to the first quoted line; this may fail if there's
  " no quote, which is fine
  call search('\m^>', 'c')

  " Delete quoted blank lines or quoted greetings until we get to something
  " with substance.  Yes, I like Perl, how could you tell?
  while getline('.') =~? '^> *'
        \ . '\%('
          \ . '\%('
            \ . 'g''\=day'
            \ . '\|\%(good \)\=\%(morning\|afternoon\|evening\)'
            \ . '\|h[eu]\%(ll\|rr\)o\+'
            \ . '\|hey\+'
            \ . '\|hi\+'
            \ . '\|sup'
            \ . '\|what''s up'
            \ . '\|yo'
          \ . '\)'
          \ . '[[:punct:] ]*'
          \ . '\%('
            \ . '\a\+'
            \ . '[[:punct:] ]*'
          \ . '\)\='
        \ . '\)\=$'
    delete
  endwhile

  " Now move to the first quoted or unquoted blank line
  call search('\m^>\=$', 'c')

endif

" Normalise quoting
for lnum in range(1, line('$'))

  " Get current line
  let line = getline(lnum)

  " Get the leading quote string, if any; stop if there isn't one
  let quote = matchstr(line, '^[> ]\+')
  if strlen(quote) == 0
    continue
  endif

  " Normalise the quote with no spaces
  let quote = substitute(quote, '[^>]', '', 'g')

  " Re-set the line
  let line = substitute(line, '^[> ]\+', quote, '')
  call setline(lnum, line)

endfor

" Add a space to the end of wrapped lines for format-flowed mail
setlocal formatoptions+=w
let b:undo_ftplugin .= '|setlocal formatoptions<'

" Mail-specific handling for custom vim-squeeze-repeat-blanks plugin
if exists('loaded_squeeze_repeat_blanks')

  " Set the blank line pattern
  let b:squeeze_repeat_blanks_blank = '^[ >]*$'
  let b:undo_ftplugin .= '|unlet b:squeeze_repeat_blanks_blank'

  " If there is anything quoted in this message (i.e. it looks like a reply),
  " squeeze blanks, but don't report lines deleted
  if search('\m^>', 'cnw')
    silent SqueezeRepeatBlanks
  endif

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
