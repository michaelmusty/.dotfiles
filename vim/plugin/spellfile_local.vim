if exists('loaded_spellfile_local') || $MYVIM ==# ''
  finish
endif
let loaded_spellfile_local = 1

EnsureDir $MYVIM/cache/spell

let spellfile = join([
      \ substitute(v:lang, '_.*', '', ''),
      \ &encoding
      \ ], '.') . '.add'
execute 'set spellfile=$MYVIM/cache/spell/'.spellfile

EnsureDir $MYVIM/cache/spell/local

function! AddLocalSpellfile() abort
  let spellfile = join([
        \ substitute(expand('%:p'), '[^0-9A-Za-z_.-]', '%', 'g'),
        \ substitute(v:lang, '_.*', '', ''),
        \ &encoding
        \ ], '.') . '.add'
  setlocal spellfile<
  execute 'setlocal spellfile+=$MYVIM/cache/spell/local/'.spellfile
endfunction
autocmd vimrc BufRead *
      \ call AddLocalSpellfile() | nnoremap <buffer> zG 2zg
