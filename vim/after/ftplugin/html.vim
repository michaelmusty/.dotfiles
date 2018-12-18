" Don't load if the buffer is not actually HTML (e.g. Markdown)
if &filetype !=# 'html'
  finish
endif

" Use tidy(1) for checking
compiler tidy
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal errorformat< makeprg<'

" tidy(1) copes fine with formatting an entire document, but not just part of
" it; we map \= to do the former, but don't actually set 'equalprg', falling
" back on the good-enough built-in Vim indentation behavior.
nnoremap <buffer> <Leader>= :<C-U>call html#TidyBuffer()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <Leader>='

" Set up hooks for timestamp updating
augroup html_timestamp
  autocmd BufWritePre <buffer>
        \ if exists('b:html_timestamp_check')
        \|  call html#TimestampUpdate()
        \|endif
augroup END
let b:undo_ftplugin .= '|execute ''autocmd! html_timestamp'''
      \ . '|augroup! html_timestamp'

" Stop here if the user doesn't want ftplugin mappings
if exists('g:no_plugin_maps') || exists('g:no_html_maps')
  finish
endif

" Transform URLs to HTML anchors
nnoremap <buffer> <LocalLeader>r
      \ :<C-U>call html#UrlLink()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>r'

" Switch to PHP filetype for templated PHP
nnoremap <buffer> <LocalLeader>f
      \ :<C-U>setlocal filetype=php<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>f'
