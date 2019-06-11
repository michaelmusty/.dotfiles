function! utc#(command) abort
  let tz = expand('$TZ')
  let $TZ = 'UTC' | execute a:command | let $TZ = tz
endfunction
