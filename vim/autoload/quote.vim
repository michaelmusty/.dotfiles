" Quote lines in mail and mail-based formats: Markdown, Git commits, etc
function! quote#Quote() abort
  set operatorfunc=quote#QuoteOpfunc
  return 'g@'
endfunction
function! quote#QuoteOpfunc(type) abort
  for l:li in range(line('''['), line(''']'))
    let l:line = getline(l:li)
    call setline(l:li, '>'.l:line)
  endfor
endfunction
