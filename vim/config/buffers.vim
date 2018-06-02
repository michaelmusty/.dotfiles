" Allow jumping between windows and tabs to find an open instance of a given
" buffer with :sbuffer.
set switchbuf=useopen
if v:version >= 701
  set switchbuf+=usetab
endif

" Cycle back and forth through buffers.
nnoremap <silent>
      \ [b
      \ :<C-U>bp<CR>
nnoremap <silent>
      \ ]b
      \ :<C-U>bn<CR>
