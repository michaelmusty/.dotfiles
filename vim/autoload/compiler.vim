function! compiler#Make(compiler) abort
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  endif
  execute 'compiler ' . a:compiler
  lmake!
  lwindow
  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  endif
endfunction
