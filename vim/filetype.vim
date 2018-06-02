" Override filetypes.vim
if exists('g:did_load_filetypes')
  finish
endif
let g:did_load_filetypes = 1

" Use only the rules in ftdetect
augroup filetypedetect
  autocmd!
  runtime! ftdetect/*.vim
augroup END
