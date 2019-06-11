if exists('loaded_utc')
  finish
endif
let loaded_utc = 1
command! -bar -complete=command -nargs=1 UTC
      \ call s:UTC(<q-args>)
