" Define header fields for high, low, and normal priorities
let s:fields = {
      \ 'high': {
        \ 'Importance': 'High',
        \ 'X-Priority': '1',
        \},
      \ 'low': {
        \ 'Importance': 'Low',
        \ 'X-Priority': '5',
        \},
      \ 'normal': {},
      \}

" Set the priority headers; pass in "high", "low", or "normal"
function! mail#importance#Set(level) abort
  let header = mail#header#Read()
  let fields = s:fields[a:level]
  for name in ['Importance', 'X-Priority']
    if has_key(fields, name)
      call mail#header#field#Set(header, name, fields[name])
    else
      call mail#header#field#Clear(header, name)
    endif
  endfor
  call mail#header#Write(header)
endfunction
