"
" spellfile_local.vim: Set extra 'spellfile' elements for full file paths and
" filetype, to give the option of adding to file-specific or filetype-specific
" spelling word lists.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('loaded_spellfile_local') || &compatible
  finish
endif
let loaded_spellfile_local = 1

" For various events involving establishing or renaming a file buffer or
" changing its filetype, rebuild the 'spellfile' definition accordingly
"
augroup spellfile_local
  autocmd BufFilePost,BufNewFile,BufRead,EncodingChanged,FileType *
        \ call spellfile_local#()
augroup END
