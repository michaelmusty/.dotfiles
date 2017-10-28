" Load plugins for file types
if has('autocmd')
  filetype plugin on
endif

" Use all ancestors of current directory for :find
if has('file_in_path')
  set path=**
endif

" Try Mac line-endings if UNIX or DOS don't make sense; this has never
" happened to me but who knows, it might one day
set fileformats+=mac

" If the Vim buffer for a file doesn't have any changes and Vim detects the
" file has been altered, quietly update it
set autoread

" Save a file automatically if I change buffers or perform operations with the
" argument list; this is particularly helpful for me as I don't use 'hidden'
set autowrite

" I really like ZZ and ZQ, so I wrote a couple more mappings; ZW forces a
" write of the current buffer, but doesn't quit, and ZA forces a write of all
" buffers but doesn't quit
nnoremap ZW :w!<CR>
nnoremap ZA :wa!<CR>
