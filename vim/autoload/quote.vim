" Quote lines in mail and mail-based formats: Markdown, Git commits, etc

" Operator function wrapper for the mapping to call
function! quote#Quote() abort
  set operatorfunc=quote#QuoteOpfunc
  return 'g@'
endfunction

" Quoting operator function
function! quote#QuoteOpfunc(type) abort

  " Make character and space appending configurable
  let char = get(b:, 'quote_char', '>')
  let space = get(b:, 'quote_space', 1)

  " Iterate over each matched line
  for li in range(line('''['), line(''']'))

    " Get current line text
    let cur = getline(li)

    " Don't quote the first or last lines if they're blank
    if !strlen(cur) && (li == line('''[') || li == line(''']'))
      continue
    endif

    " If configured to do so, add a a space after the quote character, but
    " only if this line isn't already quoted
    let new = char
    if space && cur[0] != char
      let new .= ' '
    endif
    let new .= cur
    call setline(li, new)

  endfor

endfunction

" Tack on reformatting the edited text afterwards
function! quote#QuoteReformat() abort
  set operatorfunc=quote#QuoteReformatOpfunc
  return 'g@'
endfunction

" Wrapper operator function to reformat quoted text afterwards
function! quote#QuoteReformatOpfunc(type) abort
  call quote#QuoteOpfunc(a:type)
  normal! '[gq']
endfunction
