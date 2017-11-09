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
