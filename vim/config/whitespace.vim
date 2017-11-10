" Adopt the indent of the last line on new lines; interestingly, plugins that
" do clever things with indenting will often assume this is set
set autoindent

" Use spaces instead of tabs
set expandtab

" Indent with four spaces when an indent operation is used
set shiftwidth=4

" Insert four spaces when Tab is pressed
set softtabstop=4

" Indent intelligently to 'shiftwidth' at the starts of lines with Tab, but
" use 'tabstop' everywhere else
set smarttab

" When indenting lines with < or >, round the indent to a multiple of
" 'shiftwidth', so even if the line is indented by one space it will indent
" up to 4 and down to 0, for example
set shiftround

" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" Rebind normal J to run plugin-defined join that doesn't jump around, but
" only if we have the eval feature, because otherwise this mapping won't exist
" and we should keep the default behaviour
if has('eval')
  nmap J <Plug>FixedJoin
endif

" \x strips trailing whitespace via a custom plugin
nmap <Leader>x <Plug>StripTrailingWhitespace
