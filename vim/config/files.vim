" Load plugins for file types
if has('autocmd')
  filetype plugin indent on
endif

" Bind \p to show filetype
nnoremap <silent>
      \ <Leader>p
      \ :<C-U>set filetype?<CR>

" Use UTF-8 by default wherever possible
if has('multi_byte')
  set encoding=utf-8
endif

" Use all ancestors of current directory for :find
if has('file_in_path')
  set path=**
endif

" If the Vim buffer for a file doesn't have any changes and Vim detects the
" file has been altered, quietly update it
set autoread

" Save a file automatically if I change buffers or perform operations with the
" argument list; this is particularly helpful for me as I don't use 'hidden'
set autowrite

" Don't use modelines at all, they're apparently potential security problems
" and I've never used them anyway
set nomodeline

" I really like ZZ and ZQ, so I wrote a couple more mappings; ZW forces a
" write of the current buffer, but doesn't quit, and ZA forces a write of all
" buffers but doesn't quit
nnoremap <silent>
      \ ZW
      \ :<C-U>write!<CR>
nnoremap <silent>
      \ ZA
      \ :<C-U>wall!<CR>
