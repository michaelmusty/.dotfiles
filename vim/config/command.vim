" Keep plenty of command and search history, because disk space is cheap
set history=2000

" Always tell me the number of lines changed by a command
set report=0

" Command-line based features
if has('cmdline_info')

  " Show my current position in the status bar
  set ruler

  " Show the keystrokes being entered in the screen
  set showcmd

  " Show the mode we're using if not normal mode (e.g. --INSERT--)
  set showmode
endif

" Don't write the output of :make to the terminal
set shellpipe=>

" Always use forward slashes, I very seldom need to use Vim on Windows for
" more than scratch space anyway
set shellslash

" Tolerate typos like :Wq, :Q, or :Qa and do what I mean, including any
" arguments or modifiers; I fat-finger these commands a lot because I type
" them so rapidly, and they don't correspond to any other commands I use
if has('user_commands')
  command! -bang -complete=file -nargs=? E e<bang> <args>
  command! -bang -complete=file -nargs=? W w<bang> <args>
  command! -bang -complete=file -nargs=? WQ wq<bang> <args>
  command! -bang -complete=file -nargs=? Wq wq<bang> <args>
  command! -bang Q q<bang>
  command! -bang Qa qa<bang>
  command! -bang QA qa<bang>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
endif
