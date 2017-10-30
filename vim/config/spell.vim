" Configure spell checking features, if available
if has('spell')

  " Don't check spelling by default, but bind \s to toggle this
  set nospell
  nnoremap <leader>s :setlocal spell!<CR>

  " Use New Zealand English for spelling by default (it's almost identical
  " to British English), but bind \u to switch to US English and \z to
  " switch back
  set spelllang=en_nz
  nnoremap <leader>u :setlocal spelllang=en_us<CR>
  nnoremap <leader>z :setlocal spelllang=en_nz<CR>
endif

" Don't keep .viminfo information for files in temporary directories or shared
" memory filesystems; this is because they're used as scratch spaces for tools
" like sudoedit(8) and pass(1) and hence could present a security problem
if has('viminfo') && has('autocmd')
  augroup viminfoskip
    autocmd!
    silent! autocmd BufNewFile,BufReadPre
          \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
          \ setlocal viminfo=
  augroup END
endif
