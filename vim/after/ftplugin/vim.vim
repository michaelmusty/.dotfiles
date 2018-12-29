" Use Vint as a syntax checker
if bufname('%') !=# 'command-line'
  compiler vint
  let b:undo_ftplugin .= '|unlet b:current_compiler'
        \ . '|setlocal errorformat< makeprg<'
endif

" Specify Vim pattern flavor for regex_escape.vim
let b:regex_escape_flavor = 'vim'
let b:undo_ftplugin .= '|unlet b:regex_escape_flavor'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_vim_maps')
  finish
endif

" ,K runs :helpgrep on the word under the cursor
nnoremap <buffer> <LocalLeader>K
      \ :<C-U>helpgrep <cword><CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>K'
