if exists('loaded_spellfile_local')
  finish
endif
let loaded_spellfile_local = 1

EnsureDir $MYVIM/cache/spell

let spellfile = join([
      \ substitute(v:lang, '_.*', '', ''),
      \ &encoding
      \ ], '.') . '.add'
execute 'set spellfile=$MYVIM/cache/spell/'.spellfile

Establish $MYVIM/cache/spell/local

function! AddLocalSpellFile() abort
  let spellfile = join([
        \ substitute(expand('%:p'), '[^0-9A-Za-z_.-]', '%', 'g'),
        \ substitute(v:lang, '_.*', '', ''),
        \ &encoding
        \ ], '.') . '.add'
  setlocal spellfile<
  execute 'setlocal spellfile+=$MYVIM/cache/spell/local/'.spellfile
  nnoremap <buffer> zG 2zg
endfunction

command! AddLocalSpellFile
      \ call AddLocalSpellFile()

augroup spellfile_local
  autocmd BufRead *
        \ AddLocalSpellFile
augroup END
