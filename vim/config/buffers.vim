" Allow jumping between windows and tabs to find an open instance of a given
" buffer with :sbuffer.
set switchbuf=useopen
if v:version >= 701
  set switchbuf+=usetab
endif
