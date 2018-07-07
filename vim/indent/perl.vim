" Custom Vim indent file for Perl5; the stock one didn't suit me.

" Only load this indent file when no other was loaded.
if exists('b:did_indent') || &compatible
  finish
endif
let b:did_indent = 1

" Indent settings
setlocal indentexpr=GetPerlIndent(v:lnum)
setlocal indentkeys=o,O,0=,0=},0=),0=],0=&&,0=\|\|,0=//,0=?,0=:,<Space>

" Build patterns for heredoc indenting. Note that we detect indented heredocs
" with tildes like <<~EOF, but we don't treat them any differently. We don't
" strictly match the quotes either, in an effort to keep this fast.
let s:heredoc_word = '\I\i*'
let s:heredoc_open = '<<\~\?'
      \ . '\('
      \ . '\\\?' . s:heredoc_word
      \ . '\|'
      \ . "['`\"]" . s:heredoc_word . "['`\"]"
      \ . '\)'
      \ . '.*;\s*$'

" Define indent function
function! GetPerlIndent(lnum)

  " Get previous line, bail if none
  let l:pn = prevnonblank(a:lnum - 1)
  if !l:pn
    return 0
  endif

  " Heredoc and POD flags
  let l:heredoc = 0
  let l:pod = 0

  " Start loop back through up to 512 lines of context
  let l:lim = 512
  let l:hpn = a:lnum > l:lim ? a:lnum - l:lim : 0
  while l:hpn < a:lnum
    let l:hpl = getline(l:hpn)

    " If we're not in a heredoc and not in a comment ...
    if !l:heredoc && l:hpl !~# '^\s*#'

      " POD switching; match any section so that we can handle long PODs
      if stridx(l:hpl, '=') == 0
        let l:pod = stridx(l:hpl, '=cut') != 0

      " Heredoc switch on
      else
        let l:hpm = matchstr(l:hpl, s:heredoc_open)
        if strlen(l:hpm)
          let l:heredoc = 1
          let l:hpw = matchstr(l:hpm, s:heredoc_word)
          let l:pn = l:hpn
        endif
      endif

    " If we are in a heredoc and we found the token word, finish it
    elseif l:heredoc && l:hpl =~# '^'.l:hpw.'\>'
      let l:heredoc = 0
      unlet l:hpw
    endif

    " Bump the loop index
    let l:hpn = l:hpn + 1

  endwhile

  " If we ended up in a heredoc, never indent.
  if l:heredoc
    return 0
  endif

  " If we're in POD, just autoindent; simple and good enough.
  if l:pod
    return indent(a:lnum - 1)
  endif

  " Get data of previous non-blank and non-heredoc line
  let l:pl = getline(l:pn)
  let l:pi = indent(l:pn)

  " Just follow comment indent
  if l:pl =~# '^\s*#'
    return l:pi
  endif

  " Get current line properties
  let l:cl = getline(a:lnum)

  " Get value of 'shiftwidth'
  let l:sw = &shiftwidth ? &shiftwidth : &tabstop

  " Base indent with any fractional indent removed
  let l:pb = l:pi - l:pi % l:sw

  " Handle open and closing brackets
  let l:open = l:pl =~# '[{([]\s*$'
  let l:shut = l:cl =~# '^\s*[])}]'
  if l:open || l:shut
    let l:in = l:pb
    if l:open
      let l:in = l:in + l:sw
    endif
    if l:shut
      let l:in = l:in - l:sw
    endif
    return l:in > 0 ? l:in : 0
  endif

  " Never continue after a semicolon or a double-underscore
  if l:pl =~# '\;\s*$'
        \ || l:pl =~# '__DATA__'
        \ || l:pl =~# '__END__'
    return l:pb

  " Line continuation hints
  elseif l:cl =~# '^\s*\(and\|or\|xor\)'
        \ || l:cl =~# '^\s*\(&&\|||\|//\)'
        \ || l:cl =~# '^\s*[?:=]'
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
