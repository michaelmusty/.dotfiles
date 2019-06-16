if exists('loaded_spellfile_local') || &compatible
  finish
endif
let loaded_spellfile_local = 1

command! -bar SetLocalSpellFiles
      \ call spellfile_local#()

augroup spellfile_local
  autocmd BufNew,BufRead *
        \ SetLocalSpellFiles
augroup END
