" Don't append spaces after quote chars, for strict compliance with
" format=flowed
let b:quote_space = 0
let b:undo_ftplugin .= '|unlet b:quote_space'

command! -bar -buffer SuggestStart
      \ call mail#SuggestStart()
let b:undo_ftplugin .= '|delcommand SuggestStart'
SuggestStart

" Normalise quoting
command -buffer -bar -range=% StrictQuote
      \ call mail#StrictQuote(<q-line1>, <q-line2>)
let b:undo_ftplugin .= '|delcommand StrictQuote'

" Add a space to the end of wrapped lines for format-flowed mail
setlocal formatoptions+=w
let b:undo_ftplugin .= '|setlocal formatoptions<'

" Mail-specific handling for custom vim-squeeze-repeat-blanks plugin
if exists('loaded_squeeze_repeat_blanks')
  let b:squeeze_repeat_blanks_blank = '^[ >]*$'
  let b:undo_ftplugin .= '|unlet b:squeeze_repeat_blanks_blank'
endif

" Spellcheck documents we're actually editing (not just viewing)
if &modifiable && !&readonly
  setlocal spell
  let b:undo_ftplugin .= '|setlocal spell<'
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

" Mappings for enforcing strict quoting
nnoremap <LocalLeader>s
      \ :StrictQuote<CR>
xnoremap <LocalLeader>s
      \ :StrictQuote<CR>

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
