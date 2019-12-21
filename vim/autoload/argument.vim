function! argument#Escape(argument) abort
  return exists('*fnameescape')
        \ ? fnameescape(a:argument)
        \ : escape(a:argument, "\n\r\t".' *?[{`$\%#''"|!<')
endfunction

