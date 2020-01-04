" RFC2822 format string for strftime()
let s:rfc_2822 = '%a, %d %b %Y %T %z'

" Write a date to the buffer, UTC or local, in the specified format,
" defaulting to RFC2822; formats are provided without the leading % signs
" before each letter, like PHP date()
"
function! put_date#(line, utc, format) abort
  let line = a:line
  let utc = a:utc
  let format = strlen(a:format)
        \ ? substitute(a:format, '\a', '%&', 'g')
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
