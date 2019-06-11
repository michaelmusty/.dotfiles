if exists('loaded_spellfile_local')
  finish
endif
let loaded_spellfile_local = 1

let s:spellfile = join([
      \ substitute(v:lang, '_.*', '', ''),
      \ &encoding
      \ ], '.') . '.add'
Establish $MYVIM/cache/spell
execute 'set spellfile=$MYVIM/cache/spell/'.s:spellfile

command! AddLocalSpellFile
      \ call spellfile_local#()

augroup spellfile_local
  autocmd BufNew,BufRead *
        \ AddLocalSpellFile
augroup END
