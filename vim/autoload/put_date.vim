let s:rfc_2822 = '%a, %d %b %Y %T %z'

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
