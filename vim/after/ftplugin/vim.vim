" Use Vint as a syntax checker
if bufname('%') !=# 'command-line'
  compiler vint
  let b:undo_ftplugin .= '|unlet b:current_compiler'
        \ . '|setlocal errorformat< makeprg<'
endif

" Specify Vim pattern flavor for regex_escape.vim
let b:regex_escape_flavor = 'vim'
let b:undo_ftplugin .= '|unlet b:regex_escape_flavor'

" Fold based on indent level, but start with all folds open
setlocal foldmethod=indent
setlocal foldlevel=99
let b:undo_ftplugin .= '|setlocal foldmethod< foldlevel<'

" Use :help as 'keywordprg' if not already set; this is the default since Vim
" v8.1.1290
if &keywordprg !=# ':help'
  setlocal keywordprg=:help
  let b:undo_ftplugin .= '|setlocal keywordprg<'
endif

" Keywords for including files
let &l:include = '\<source\>\|\<runtime!\=\>'

" Search runtime paths for included scripts
let &l:path = &runtimepath . ',' . &path

" Adjust the match words for the matchit plugin; the default filetype plugin
" matches e.g. an opening "function" with the first "return" within, which I
" don't like
if exists('loaded_matchit')
  let b:match_words = '\<fu\%[nction]\>:\<endf\%[unction]\>,'
        \ . '\<\(wh\%[ile]\|for\)\>:\<end\(w\%[hile]\|fo\%[r]\)\>,'
        \ . '\<if\>:\<el\%[seif]\>:\<en\%[dif]\>,'
        \ . '\<try\>:\<cat\%[ch]\>:\<fina\%[lly]\>:\<endt\%[ry]\>,'
        \ . '\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_vim_maps')
  finish
endif

" ,K runs :helpgrep on the word under the cursor
nnoremap <buffer> <LocalLeader>K
      \ :<C-U>helpgrep <cword><CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>K'

" ,@ executes line in normal mode
nnoremap <buffer> <LocalLeader>@
      \ ^"zyg_@z
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>@'

" ,: executes line in command mode
nnoremap <buffer> <LocalLeader>:
      \ ^"zyg_:<C-R>z<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>:'
