" Custom Vim indent file for Perl5; the stock one didn't suit me.

" Only load this indent file when no other was loaded.
if exists('b:did_indent') || &compatible
  finish
endif
let b:did_indent = 1

" Indent settings
setlocal indentexpr=GetPerlIndent(v:lnum)
setlocal indentkeys=o,O,0=,0=},0=),0=],&,<Bar>,<Space>

" Build patterns for heredoc indenting; note that we detect indented heredocs
" with tildes like <<~EOF, but we don't treat them any differently; note also
" a semicolon is required
let s:heredoc_word = '\I\i*'
let s:heredoc_open = '<<\~\?'
      \ . '\('
      \ . '\\\?' . s:heredoc_word
      \ . '\|'
      \ . "'" . s:heredoc_word . "'"
      \ . '\|'
      \ . '"' . s:heredoc_word . '"'
      \ . '\|'
      \ . '`' . s:heredoc_word . '`'
      \ . '\)'
      \ . '.*;\s*$'

" Define indent function
function! GetPerlIndent(lnum)

  " Get previous line, bail if none
  let l:pn = prevnonblank(a:lnum - 1)
  if !l:pn
    return 0
  endif

  " Heredoc and POD detection; start at top of buffer
  let l:pod = 0
  let l:hpn = 0
  while l:hpn < a:lnum
    let l:hpl = getline(l:hpn)

    " If we're not in a heredoc and not in a comment ...
    if !exists('l:hpw') && l:hpl !~# '^\s*#'

      " POD switching
      if !l:pod && stridx(l:hpl, '=pod') == 0
        let l:pod = 1
      elseif l:pod && stridx(l:hpl, '=cut') == 0
        let l:pod = 0
      else

        " Line opens with a heredoc
        let l:hpm = matchstr(l:hpl, s:heredoc_open)

        " Store the heredoc word and make this our indent reference
        if strlen(l:hpm)
          let l:hpw = matchstr(l:hpm, s:heredoc_word)
          let l:pn = l:hpn
        endif

      endif

    " If we are in a heredoc and we found the token word, finish it
    elseif exists('l:hpw') && l:hpl =~# '^'.l:hpw.'\>'
      unlet l:hpw
    endif

    " Bump the loop index
    let l:hpn = l:hpn + 1

  endwhile

  " If we ended up in a heredoc, return 0 for the indent.
  if exists('l:hpw')
    return 0
  endif

  " Get data of previous non-blank and non-heredoc line
  let l:pl = getline(l:pn)
  let l:pi = indent(l:pn)

  " Get value of 'shiftwidth'
  let l:sw = exists('*shiftwidth')
        \ ? shiftwidth()
        \ : &shiftwidth

  " If we're in POD and the indent of the previous line was less than
  " 'shiftwith', keep it there.
  if l:pod && l:pi < l:sw
    return l:pi
  endif

  " Get current line properties
  let l:cl = getline(a:lnum)

  " Base indent with any fractional indent removed
  let l:pb = l:pi - l:pi % l:sw

  " Just follow comment indent
  if l:pl =~# '^\s*#'
    return l:pi

  " Move out with closing brace
  elseif l:cl =~# '^\s*[])}]'
    return l:pb >= l:sw ? l:pb - l:sw : 0

  " Move in after opening brace
  elseif l:pl =~# '[{([]\s*$'
    return l:pb + l:sw

  " Never continue after a semicolon or a double-underscore
  elseif l:pl =~# '\;\s*$'
        \ || l:pl =~# '__DATA__'
        \ || l:pl =~# '__END__'
    return l:pb

  " Line continuation hints
  elseif l:pl =~# '[^])},]\s*$'
        \ || l:cl =~# '^\s*\(and\|or\)\>'
        \ || l:cl =~# '^\s*\(&&\|||\)'
        \ || l:cl =~# '^\s*='
    return l:pb + l:sw / 2

  " Default to indent of previous line
  else
    return l:pb

  endif

endfunction

" How to undo all of that
let b:undo_indent = 'setlocal indentexpr<'
      \ . '|setlocal indentkeys<'
      \ . '|delfunction GetPerlIndent'
