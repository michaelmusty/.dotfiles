" Quote lines in mail messages
function! mail#Quote() abort
  set operatorfunc=mail#QuoteOpfunc
  return 'g@'
endfunction
function! mail#QuoteOpfunc(type) abort
  for l:li in range(line('''['), line(''']'))
    let l:line = getline(l:li)
    call setline(l:li, '>'.l:line)
  endfor
endfunction
