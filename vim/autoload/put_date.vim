let s:rfc_2822 = '%a, %d %b %Y %T %z'

function! put_date#(line, bang, ...) abort
  let line = a:line
  let utc = a:bang ==# '!'
  let format = a:0
        \ ? substitute(a:1, '\a', '%&', 'g')
        \ : s:rfc_2822
  if utc
    if exists('$TZ')
      let tz = $TZ
    endif
    let $TZ = 'UTC'
  endif
  execute line.'put =strftime(format)'
  if exists('tz')
    let $TZ = tz
  endif
endfunction
