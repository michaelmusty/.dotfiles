" Add a field to a header, regardless of whether a field by the same name is
" already present
function! mail#header#field#Add(header, name, body) abort
  let new = {
        \ 'name': a:name,
        \ 'body': a:body,
        \}
  call add(a:header['fields'], new)
endfunction

" Set a field in a header, replacing the first one with the same name (if
" any), and and removing any others
"
function! mail#header#field#Set(header, name, body) abort
  let fields = []
  let new = {
        \ 'name': a:name,
        \ 'body': a:body,
        \}
  for field in a:header['fields']
    if field['name'] ==? a:name
      if exists('new')
        let field = new | unlet new
      else
        continue
      endif
    endif
    call add(fields, field)
  endfor
  if exists('new')
    call add(fields, new) | unlet new
  endif
  let a:header['fields'] = fields
endfunction

" Remove a header field
function! mail#header#field#Clear(header, name) abort
  let fields = []
  for field in a:header['fields']
    if field['name'] !=? a:name
      call add(fields, field)
    endif
  endfor
  let a:header['fields'] = fields
endfunction
