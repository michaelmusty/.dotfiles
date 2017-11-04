" Swap files are used if using Unix and not using sudo(8); I very seldom need
" them, but they are occasionally useful after a crash, and they don't really
" get in the way if kept in their own directory
if !strlen($SUDO_USER) && has('unix')

  " Use swap files but keep them in ~/.vim/swap; the double-slash at the end
  " of the directory prods Vim into keeping the full path to the file in its
  " undo filename to avoid collisions; the same thing works for undo files
  set swapfile
  set directory^=~/.vim/swap//

  " Create the ~/.vim/swap directory if necessary and possible
  if !isdirectory($HOME . '/.vim/swap') && exists('*mkdir')
    call mkdir($HOME . '/.vim/swap', 'p', 0700)
  endif

  " Don't keep swap files for files in temporary directories or shared memory
  " filesystems; this is because they're used as scratch spaces for tools
  " like sudoedit(8) and pass(1) and hence could present a security problem
  if has('autocmd')
    augroup dotfiles_swap_skip
      autocmd!
      autocmd BufNewFile,BufReadPre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noswapfile
    augroup END
  endif

" Otherwise, don't use swap files at all
else
  set noswapfile
endif
