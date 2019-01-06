" Make angle brackets behave like mail quotes
setlocal comments+=n:>
setlocal formatoptions+=coqr
let b:undo_ftplugin .= '|setlocal comments< formatoptions<'

" Choose the color column depending on non-comment line count
if has('autocmd') && exists('+cursorcolumn')
  augroup gitcommit_cursorcolumn
    autocmd CursorMoved,CursorMovedI <buffer>
          \ let &l:colorcolumn = gitcommit_cursorcolumn#CursorColumn()
  augroup END
  let b:undo_ftplugin .= '|execute ''autocmd! gitcommit_cursorcolumn'''
        \ . '|augroup! gitcommit_cursorcolumn'
        \ . '|setlocal colorcolumn<'
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_gitcommit_maps')
  finish
endif

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
