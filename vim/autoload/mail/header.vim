function! mail#header#Read() abort
  let fields = []
  for lnum in range(1, line('$'))
    let line = getline(lnum)
    let matchlist = matchlist(
          \ line,
          \ '^\([a-zA-Z0-9-]\+\):\s*\(\_.*\)',
          \)
    if !empty(matchlist)
      let field = {
            \ 'name': matchlist[1],
            \ 'body': matchlist[2],
            \}
      call add(fields, field)
    elseif line =~ '^\s' && exists('field')
      let field['body'] .= "\n" . line
    elseif line ==# ''
      break
    else
      throw 'Parse error'
    endif
  endfor
  let header = {
        \'fields': fields,
        \}
  return header
endfunction

function! mail#header#String(header) abort
  let fields = copy(a:header['fields'])
  return join(
        \ map(
          \ copy(a:header['fields']),
          \ 'v:val[''name''] . '': '' . v:val[''body''] . "\n"'),
        \ '',
        \)
endfunction

function! mail#header#Write(header) abort
  let start = 1
  for lnum in range(1, line('$'))
    if getline(lnum) ==# ''
      break
    endif
    let end = lnum
  endfor
  let curpos = getpos('.')
  if exists('end')
    let range = join([start, end], ',')
    execute join(['silent', range, 'delete'])
  endif
  silent 0 put =mail#header#String(a:header)
  call setpos('.', curpos)
endfunction
