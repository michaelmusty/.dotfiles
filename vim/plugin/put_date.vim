if exists('loaded_put_date')
  finish
endif
let loaded_put_date = 1
command! -bang -bar -nargs=* -range PutDate
      \ call put_date#(<q-line1>, <q-bang>, <q-args>)
