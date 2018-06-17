" Run a compiler check (:lmake, :lwindow) without trampling over previous
" settings, by temporarily loading the compiler with the given name
function! compiler#Make(compiler) abort

  " Save the given compiler or failing that the current 'makeprg' and
  " 'errorformat' values
  if exists('b:current_compiler')
    let l:save_compiler = b:current_compiler
  else
    let l:save_makeprg = &makeprg
    let l:save_errorformat = &errorformat
  endif

  " Choose the compiler
  execute 'compiler ' . a:compiler

  " Run the 'makeprg' with results in location list
  lmake!

  " If we saved a compiler, switch back to it, otherwise restore the previous
  " values for 'makeprg' and 'errorformat'
  if exists('l:save_compiler')
    execute 'compiler ' . l:save_compiler
  else
    unlet! b:current_compiler
    let &l:makeprg = l:save_makeprg
    let &l:errorformat = l:save_errorformat
  endif

  " Show location list
  lwindow

endfunction
