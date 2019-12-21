" Escape text for use as an Ex command argument
function! escape#Arg(arg) abort
  return exists('*fnameescape')
        \ ? fnameescape(a:arg)
        \ : escape(a:arg, "\n\r\t".' *?[{`$\%#''"|!<')
endfunction

" Escape text for use as a list item
function! escape#Item(item) abort
  return escape(a:item, ',')
endfunction

" Escape wildcard characters in list items to prevent e.g. tilde or glob
" expansion in the resulting item
"
function! escape#Wild(string) abort
  return escape(a:string, '\*?[{`''$~')
endfunction
