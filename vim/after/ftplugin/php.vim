" Extra configuration for 'php' filetypes
if &compatible || v:version < 700 || exists('b:did_ftplugin_after')
  finish
endif
if &filetype !=# 'php'
  finish
endif
let b:did_ftplugin_after = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_after'

" Set comment formats
setlocal comments=s1:/*,m:*,ex:*/,://,:#
setlocal formatoptions+=or
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|setlocal comments<'
      \ . '|setlocal formatoptions<'

" Define keywords for matchit.vim
if exists('g:loaded_matchit')
  let b:match_words = '<?php:?>'
        \ . ',\<do\>:\<while\>'
        \ . ',\<for\>:\<endfor\>'
        \ . ',\<foreach\>:\<endforeach\>'
        \ . ',\<if\>:\<elseif\>:\<else\>:\<endif\>'
        \ . ',\<switch\>:\<endswitch\>'
        \ . ',\<while\>:\<endwhile\>'
  let b:undo_ftplugin = 'unlet b:match_words'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_php_maps')
  finish
endif

" Set mappings
nnoremap <buffer> <LocalLeader>c
      \ :<C-U>call compiler#Make('php')<CR>
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|nunmap <buffer> <LocalLeader>c'
