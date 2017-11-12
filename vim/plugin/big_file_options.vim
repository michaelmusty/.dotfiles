"
" big_file_options.vim: When opening a large file, take some measures to keep
" things loading quickly.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_big_file_options') || &compatible || !has('autocmd')
  finish
endif
let g:loaded_big_file_options = 1

" Default threshold is 10 MiB
if !exists('g:big_file_size')
  let g:big_file_size = 10 * 1024 * 1024
endif

" Default to leaving syntax highlighting off
if !exists('g:big_file_syntax')
  let g:big_file_syntax = 0
endif

" Cut 'synmaxcol' down to this or smaller for big files
if !exists('g:big_file_synmaxcol')
  let g:big_file_synmaxcol = 256
endif

" Declare function for turning off slow options
function! s:BigFileOptions()

  " Don't do anything if the buffer size is under the threshold
  if line2byte(line('$') + 1) <= g:big_file_size
    return
  endif

  " Turn off backups, swap files, and undo files
  setlocal nobackup
  setlocal nowritebackup
  setlocal noswapfile
  if has('persistent_undo')
    setlocal noundofile
  endif

  " Limit the number of columns of syntax highlighting
  if exists('+synmaxcol')
        \ && &synmaxcol > g:big_file_synmaxcol
    execute 'setlocal synmaxcol=' . g:big_file_synmaxcol
  endif

  " Disable syntax highlighting if configured to do so
  if !g:big_file_syntax
    setlocal syntax=OFF
  endif

endfunction

" Define autocmd for calling to check filesize
augroup big_file_options_bufreadpost
  autocmd!
  autocmd BufReadPost
        \ *
        \ call s:BigFileOptions()
augroup end
