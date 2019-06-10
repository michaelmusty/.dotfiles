if exists('loaded_put_date')
  finish
endif
let loaded_put_date = 1

" Define a :PutDate command that inserts a line into the buffer with an
" RFC-2822 date string, using the system strftime() implementation.  Allow it
" to accept a range which defaults to the current line.
"
command! -bar -range PutDate
      \ <line1>put =strftime('%a, %d %b %Y %T %z')
