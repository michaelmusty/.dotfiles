" Quote lines in mail and mail-based formats: Markdown, Git commits, etc

" Operator function wrapper for the mapping to call
function! quote#Quote() abort
  set operatorfunc=quote#QuoteOpfunc
  return 'g@'
endfunction

" Quoting operator function
function! quote#QuoteOpfunc(type) abort

  " May as well make this configurable
  let l:char = exists('b:quote_char')
        \ ? b:quote_char
        \ : '>'

  " Iterate over each matched line
  for l:li in range(line('''['), line(''']'))

    " Only add a space after the quote character if this line isn't already
    " quoted with the same character
    let l:cur = getline(l:li)
    let l:new = stridx(l:cur, l:char) == 0
          \ ? l:char.l:cur
          \ : l:char.' '.l:cur
    call setline(l:li, l:new)

  endfor

endfunction
