" Allow jumping between windows and tabs to find an open instance of a given
" buffer with :sbuffer.
if v:version >= 701
  set switchbuf=useopen,usetab
else
  set switchbuf=useopen
endif

