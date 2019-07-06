function! plugin#Ready(name) abort
  return &loadplugins
        \ && globpath(&runtimepath, 'plugin/'.a:name.'.vim') != ''
endfunction

