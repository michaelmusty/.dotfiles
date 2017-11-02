"
" bigfile.vim: When opening a large file, take some measures to keep things
" loading quickly.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" Copyright: 2017
" License: Same as Vim itself
"
if has('eval') && has('autocmd')

  " Default threshold is 10 MiB
  if !exists('g:bigfile_size')
    let g:bigfile_size = 10 * 1024 * 1024
  endif

  " Cut 'synmaxcol' down to this or smaller for big files
  if !exists('g:bigfile_size_synmaxcol')
    let g:bigfile_size_synmaxcol = 256
  endif

  " Declare function for turning off slow options
  function! s:BigFileOptions(name, size)

    " Don't do anything if the file is under the threshold
    if getfsize(a:name) <= a:size
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
    if exists('&synmaxcol') && &synmaxcol > g:bigfile_size_synmaxcol
      execute 'setlocal synmaxcol=' . g:bigfile_size_synmaxcol
    endif

  endfunction

  " Define autocmd for calling to check filesize
  augroup bigfile_options_bufreadpre
    autocmd!
    autocmd BufReadPre * call s:BigFileOptions(expand('<afile>'), g:bigfile_size)
  augroup end

endif
