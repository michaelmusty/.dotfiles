" Default to no swap files at all, in a way that even ancient/tiny Vims will
" understand; the auto_cache_dirs.vim plugin will take care of re-enabling
" this with a 'directory' setting
set noswapfile

" Don't keep swap files from temporary directories or shared memory in case
" they're secrets
if has('autocmd')
  augroup dotfiles_swap_skip
    autocmd!
    autocmd BufNewFile,BufReadPre
          \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
          \ setlocal noswapfile
  augroup END
endif
