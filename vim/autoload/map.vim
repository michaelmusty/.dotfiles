function! map#(list, Func) abort
  return has('patch-7.4.1989')
        \ ? map(a:list, a:Func)
        \ : map(a:list, string(a:Func).'(0, v:val)')
endfunction
