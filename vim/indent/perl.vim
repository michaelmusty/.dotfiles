" Custom Vim indent file for Perl5; the stock one didn't suit me.

" Only load this indent file when no other was loaded.
if exists('b:did_indent') || &compatible
  finish
endif
let b:did_indent = 1

" Indent settings
setlocal indentexpr=GetPerlIndent()
setlocal indentkeys=o,O,0},0),0]

" Define indent function
function! GetPerlIndent()

  " Get previous line, bail if none
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

  " Just follow comment indent
  if l:pl =~# '^\s*#'
    return l:pi

  " Entering closing brace
  elseif l:cl =~# '^\s*[])}]'
    return l:pi >= l:sw
          \ ? l:pi - l:sw - l:pi % l:sw
          \ : 0

  " After opening brace
  elseif l:pl =~# '[{([]\s*$'
    return l:pi + l:sw

  " After a semicolon, comma, or closing brace
  elseif l:pl =~# '[;,}]\s*$'
    return l:pi - l:pi % l:sw

  " Continued line; add half 'shiftwidth'
  elseif l:sw >= 2
    return l:pi + l:sw / 2
  endif

endfunction

" How to undo all of that
let b:undo_indent = '|setlocal indentexpr<'
      \ . '|setlocal indentkeys<'
      \ . '|delfunction GetPerlIndent'
