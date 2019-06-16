if exists('loaded_put_date')
  finish
endif
let loaded_put_date = 1
let s:rfc_2822 = '%a, %d %b %Y %T %z'
command! -bar -range PutDate
      \ <line1>put =strftime(s:rfc_2822)
