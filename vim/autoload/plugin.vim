" Check whether plugins are enabled and a specific named plugin (excluding
" extension .vim) is available somewhere within 'runtimepath'
"
function! plugin#Ready(name) abort
  return &loadplugins
        \ && globpath(&runtimepath, 'plugin/'.a:name.'.vim') !=# ''
endfunction
