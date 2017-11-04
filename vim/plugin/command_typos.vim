" Tolerate typos like :Wq, :Q, or :Qa and do what I mean, including any
" arguments or modifiers; I fat-finger these commands a lot because I type
" them so rapidly, and they don't correspond to any other commands I use
if has('eval') && has('user_commands')
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
