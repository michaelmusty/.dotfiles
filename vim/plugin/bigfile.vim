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
  if !exists('g:big_file_size')
    let g:big_file_size = 10 * 1024 * 1024
  endif

  " Declare function for turning off slow options
  function! s:BigFileMeasures()
    let l:file = expand('<afile>')
    if getfsize(l:file) > g:big_file_size
      setlocal nobackup
      setlocal nowritebackup
      setlocal noswapfile
      if has('persistent_undo')
        setlocal noundofile
      endif
      if exists('&synmaxcol')
        setlocal synmaxcol=256
      endif
    endif
  endfunction

  " Define autocmd for calling to check filesize
  augroup dotfiles_big_file_measures
    autocmd!
    autocmd BufReadPre * call s:BigFileMeasures()
  augroup end
endif
