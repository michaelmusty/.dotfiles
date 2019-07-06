" We declare a wrapper around map() to allow us always to call it with
" a Funcref as the second function parameter, which isn’t directly supported
" by map() until Vim v7.4.1989.  If the running version is older than that,
" apply string() to the Funcref to use the older calling convention.
"
" <https://github.com/vim/vim/releases/tag/v7.4.1989>
"
function! map#(list, Func) abort
  return has('patch-7.4.1989')
        \ ? map(a:list, a:Func)
        \ : map(a:list, string(a:Func).'(0, v:val)')
endfunction
