function! spellfile_local#() abort
  let spellfile = join([
        \ substitute(expand('%:p'), '[^0-9A-Za-z_.-]', '%', 'g'),
        \ substitute(v:lang, '_.*', '', ''),
        \ &encoding
        \ ], '.') . '.add'
  Establish $MYVIM/cache/spell/local
  execute 'setlocal spellfile+=$MYVIM/cache/spell/local/'.spellfile
  nnoremap <buffer> zG 2zg
  xnoremap <buffer> zG 2zg
endfunction
