" None of this is appropriate for other filetypes that are just sourcing this
" filetype's scripts in, e.g. Markdown, PHP, so cut that off here
if &filetype !=# 'html'
  finish
endif

" Spellcheck documents we're actually editing (not just viewing)
if &modifiable && !&readonly
  setlocal spell
  let b:undo_ftplugin .= '|setlocal spell<'
endif

" Use tidy(1) for checking
compiler tidy
let b:undo_ftplugin .= '|unlet b:current_compiler'
      \ . '|setlocal errorformat< makeprg<'

" tidy(1) copes fine with formatting an entire document, but not just part of
" it; we map \= to do the former, but don't actually set 'equalprg' for the
" latter, instead falling back on the good-enough built-in Vim indentation
" behavior
nnoremap <buffer> <Leader>= :<C-U>call html#Tidy()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <Leader>='

" Set up hooks for timestamp updating
augroup html_timestamp
  autocmd BufWritePre <buffer>
        \ if exists('b:html_timestamp_check')
        \|  call html#timestamp#Update()
        \|endif
augroup END
let b:undo_ftplugin .= '|execute ''autocmd! html_timestamp'''
      \ . '|augroup! html_timestamp'

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_html_maps')
  finish
endif

" Transform URLs to HTML anchors
nnoremap <buffer> <LocalLeader>r
      \ :<C-U>call html#url#Anchor()<CR>
let b:undo_ftplugin .= '|nunmap <buffer> <LocalLeader>r'
