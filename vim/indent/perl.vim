" Custom Vim indent file for Perl5; the stock one didn't suit me.

" Only load this indent file when no other was loaded.
if exists('b:did_indent') || &compatible
  finish
endif
let b:did_indent = 1

" Define indent function
function! GetPerlIndent()

  " Just return 0 if we have no previous line to work from
  let l:pn = prevnonblank(v:lnum - 1)
  if !l:pn
    return 0
  endif

  " Get line properties
  let l:cl = getline(v:lnum)
  let l:ci = indent(l:cn)
  let l:pl = getline(l:pn)
  let l:pi = indent(l:pn)

  " Get value of 'shiftwidth'
  let l:sw = exists('*shiftwidth')
        \ ? shiftwidth()
        \ : &shiftwidth

  " Don't touch comments
  if l:pl =~# '^\s*#'
    return l:pi

  " After opening brace
  elseif l:pl =~# '[{([]\s*$'

    " Closing brace
    if l:cl =~# '^\s*[])}]'
      return l:pi

    " Block content
    else
      return l:pi + l:sw
    endif

  " Closing brace
  elseif l:cl =~# '^\s*[])}]'

    " Reduce indent if possible
    if l:pi >= l:sw
      return l:pi - l:sw
    else
      return 0
    endif

  " After a semicolon, comma, or closing brace
  elseif l:pl =~# '[;,}]\s*$'
    return l:pi - (l:pi % l:sw)

  " Continued line; add half shiftwidth
  elseif l:sw >= 2
    return l:pi + l:sw / 2
  endif

endfunction

" Indent settings
setlocal indentexpr=GetPerlIndent()
setlocal indentkeys+=0},0),0]

" Undo all of the above crap
let b:undo_indent = '|setlocal indentexpr<'
      \ . '|setlocal indentkeys<'
      \ . '|delfunction GetPerlIndent'
