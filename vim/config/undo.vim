" Rebind Ctrl-C in insert mode to undo the current insert operation
inoremap <C-c> <C-c>u

" Keep screeds of undo history
set undolevels=2000

" 'undodir' and 'undofile' settings will be taken care of by the
" auto_undodir.vim plugin if applicable/possible
if has('persistent_undo')

  " Turn off the option by default
  set noundofile

  " Don't keep undo files from temporary directories or shared memory in case
  " they're secrets
  if has('autocmd')
    augroup dotfiles_undo_skip
      autocmd!
      autocmd BufWritePre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noundofile
    augroup END
  endif

endif
