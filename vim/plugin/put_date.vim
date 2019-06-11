if exists('loaded_put_date')
  finish
endif
let loaded_put_date = 1
command! -bar -range PutDate
      \ <line1>put =strftime('%a, %d %b %Y %T %z')
