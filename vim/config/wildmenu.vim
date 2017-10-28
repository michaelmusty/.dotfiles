" Configuration for the command completion feature; rather than merely cycling
" through possible completions with Tab, show them above the command line
if has('wildmenu')

  " Use the wild menu, both completing and showing all possible completions
  " with a single Tab press, just as I've configured Bash to do
  set wildmenu
  set wildmode=longest:list

  " Don't complete certain files that I'm not likely to want to manipulate
  " from within Vim:
  if has('wildignore')
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
  endif

  " Complete files without case sensitivity, if the option is available
  if exists('&wildignorecase')
    set wildignorecase
  endif
endif
