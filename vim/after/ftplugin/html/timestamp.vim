" html/timestamp.vim: Update timestamps in HTML files on save.

" Don't load if running compatible or too old
if &compatible || v:version < 700
  finish
endif

" Don't load if already loaded
if exists('b:did_ftplugin_html_timestamp')
  finish
endif

" Flag as loaded
let b:did_ftplugin_html_timestamp = 1
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|unlet b:did_ftplugin_html_timestamp'

" Set up appropriate hooks
augroup html_timestamp
  autocmd!
  autocmd BufWritePre *.html
        \ if exists('b:html_timestamp_check')
        \|  call html#timestamp#Update()
        \|endif
augroup END
let b:undo_ftplugin = b:undo_ftplugin
      \ . '|augroup html_timestamp|autocmd!|augroup END'
      \ . '|augroup! html_timestamp'
