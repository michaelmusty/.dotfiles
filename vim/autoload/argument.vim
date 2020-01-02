" Escape a single argument for use on an Ex command line; essentially
" a backport of fnameescape() for versions before v7.1.299
"
function! argument#Escape(argument) abort
  return exists('*fnameescape')
        \ ? fnameescape(a:argument)
        \ : escape(a:argument, "\n\r\t".' *?[{`$\%#''"|!<')
endfunction
