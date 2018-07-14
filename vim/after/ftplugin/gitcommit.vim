" Extra configuration for Git commit messages
if &filetype !=# 'gitcommit' || v:version < 700
  finish
endif

" Make angle brackets behave like mail quotes
setlocal comments+=n:>
setlocal formatoptions+=coqr
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'

" Choose the color column depending on non-comment line count
if has('autocmd') && exists('+cursorcolumn')
  augroup gitcommit
    autocmd CursorMoved,CursorMovedI <buffer>
            \ let &l:colorcolumn = gitcommit#CursorColumn()
  augroup END
  let b:undo_ftplugin .= '|autocmd! gitcommit'
        \ . '|augroup! gitcommit'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_gitcommit_maps')
  finish
endif

" Mail quote mappings
nnoremap <buffer> <expr> <LocalLeader>q quote#Quote()
nnoremap <buffer> <expr> <LocalLeader>qq quote#Quote().'_'
xnoremap <buffer> <expr> <LocalLeader>q quote#Quote()
let b:undo_ftplugin .= '|nunmap <LocalLeader>q'
      \ . '|nunmap <LocalLeader>qq'
      \ . '|xunmap <LocalLeader>q'
