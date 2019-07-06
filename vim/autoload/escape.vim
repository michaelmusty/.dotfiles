function! escape#Arg(arg) abort
  return exists('*fnameescape')
        \ ? fnameescape(a:arg)
        \ : escape(a:arg, "\n\r\t".' *?[{`$\%#''"|!<')
endfunction

function! escape#Item(item) abort
  return escape(a:item, ',')
endfunction

function! escape#Wild(string) abort
  return escape(a:string, '\*?[{`''$~')
endfunction
