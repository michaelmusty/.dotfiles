function! scratch_buffer#(mods, count, ...) abort
  let command = []
  call add(command, a:mods)
  if a:count
    call add(command, a:count)
  endif
  call add(command, 'new')
  call extend(command, a:000)
  execute join(command)
  set buftype=nofile
endfunction
