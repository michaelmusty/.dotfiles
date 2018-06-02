" Adopt the indent of the last line on new lines
set autoindent

" Use spaces instead of tabs
set expandtab

" Indent with four spaces when an indent operation is used
set shiftwidth=4

" Insert four spaces when Tab is pressed
set softtabstop=4

" When indenting lines with < or >, round the indent to a multiple of
" 'shiftwidth', so even if the line is indented by one space it will indent
" up to 4 and down to 0, for example
set shiftround

" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" \x strips trailing whitespace via a custom plugin
nmap <Leader>x <Plug>StripTrailingWhitespace

" Insert blank lines above and below via a custom plugin
nmap [<Space> <Plug>PutBlankLinesAbove
nmap ]<Space> <Plug>PutBlankLinesBelow
