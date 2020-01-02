" Keys and date formats for return value of s:Timestamp()
let s:formats = {
      \ 'human': '%a, %d %b %Y %T %Z',
      \ 'machine': '%Y-%m-%dT%H:%M:%S.000Z',
      \}

" Get UTC timestamp string dictionary with layout in s:formats
function! s:Timestamp(time) abort

  " Force UTC, recording previous timezone, if any
  if exists('$TZ')
    let tz = $TZ
  endif
  let $TZ = 'UTC'

  " Get current time
  let time = localtime()

  " Fill out timestamp dictionary
  let timestamp = {}
  for key in keys(s:formats)
    let timestamp[key] = strftime(s:formats[key], time)
  endfor

  " Clear UTC and restore previous timezone, if any
  unlet $TZ
  if exists('tz')
    let $TZ = tz
  endif

  " Return filled-out timestamp dictionary
  return timestamp

endfunction

" Define timestamp prefix string
let s:prefix = 'Last updated: '

" Define pattern to match date timestamps; no ZALGO, please
let s:pattern = '\m\C'
      \.s:prefix
      \.'<time datetime="[^"]\+">'
      \.'[^<]\+'
      \.'</time>'

" Update a timestamp
function! html#timestamp#Update() abort

  " Do nothing if the buffer hasn't been modified
  if !&modified
    return
  endif

  " Find the first occurrence of the timestamp pattern, bail if none
  let lnum = search(s:pattern, 'nw')
  if !lnum
    return
  endif

  " Get timestamp dictionary
  let timestamp = s:Timestamp(localtime())

  " Fill out updated timestamp string with dictionary values
  let update = s:prefix
        \.'<time datetime="'.timestamp['machine'].'">'
        \.timestamp['human']
        \.'</time>'

  " Apply the updated timestamp
  let line = getline(lnum)
  let line = substitute(line, s:pattern, update, '')
  call setline(lnum, line)

endfunction
