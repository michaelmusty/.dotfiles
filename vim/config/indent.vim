" Indent with four literal spaces when 'expandtab' is on
set shiftwidth=4

" Insert four spaces when Tab is pressed and 'expandtab' is on
set softtabstop=4

" How many spaces to show for a literal tab when 'list' is unset
set tabstop=4

" Indent intelligently to 'shiftwidth' at the starts of lines with Tab, but
" use 'tabstop' everywhere else
set smarttab

" When indenting lines with < or >, round the indent to a multiple of
" 'shiftwidth', so even if the line is indented by one space it will indent up
" to 4 and down to 0, for example; all this when 'expandtab' is on
set shiftround

" Tabs vs spaces and automatic indentation behaviour depends on there being an
" actual filetype that's more than just plain text (or a Vim help buffer).
function! FileTypeIndentConfig(ft)
  if a:ft == '' || a:ft == 'csv' || a:ft == 'help' || a:ft == 'text'
    setlocal noautoindent noexpandtab
  else
    setlocal autoindent expandtab
  endif
endfunction

" Call the function that we just declared each time the filetype is set
augroup dfindent
  autocmd!
  autocmd FileType * call FileTypeIndentConfig(&filetype)
augroup END
