" Rebind Ctrl-C in insert mode to undo the current insert operation
inoremap <C-c> <C-c>u

" Keep screeds of undo history
set undolevels=2000

" Keep undo history in a separate file if the feature is available, we're on
" Unix, and not using sudo(8); this goes really well with undo visualization
" plugins like Gundo or Undotree.
if !strlen($SUDO_USER) && has('unix') && has('persistent_undo')

  " Keep per-file undo history in ~/.vim/undo; the double-slash at the end
  " of the directory prods Vim into keeping the full path to the file in its
  " undo filename to avoid collisions; the same thing works for swap files
  set undofile
  set undodir^=~/.vim/undo//

  " Create the ~/.vim/undo directory if necessary and possible
  if !isdirectory($HOME . '/.vim/undo') && exists('*mkdir')
    call mkdir($HOME . '/.vim/undo', 'p', 0700)
  endif

  " Don't track changes to sensitive files
  if has('autocmd')
    augroup dotfiles_undo_skip
      autocmd!
      autocmd BufWritePre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noundofile
    augroup END
  endif
endif
