" Tidy the whole buffer
function! html#Tidy() abort
  let view = winsaveview()
  %!tidy -quiet
  call winrestview(view)
endfunction

let s:formats = {
      \ 'human': '%a, %d %b %Y %T %Z',
      \ 'machine': '%Y-%m-%dT%H:%M:%S.000Z',
      \}

function! s:Timestamp(time) abort
  if exists('$TZ')
    let tz = $TZ
  endif
  let $TZ = 'UTC'
  let time = localtime()
  let timestamp = {}
  for key in keys(s:formats)
    let timestamp[key] = strftime(s:formats[key], time)
  endfor
  if exists('tz')
    let $TZ = tz
  endif
  return timestamp
endfunction

let s:pattern = '\m\C'
      \.'Last updated: '
      \.'<time datetime="[^"]\+">'
      \.'[^<]\+'
      \.'</time>'

" Update a timestamp
function! html#TimestampUpdate() abort
  if !&modified
    return
  endif
  let lnum = search(s:pattern, 'nw')
  if !lnum
    return
  endif
  let timestamp = s:Timestamp(localtime())
  let update = 'Last updated: '
        \.'<time datetime="'.timestamp['machine'].'">'
        \.timestamp['human']
        \.'</time>'
  let line = getline(lnum)
  let line = substitute(line, s:pattern, update, '')
  call setline(lnum, line)
endfunction
