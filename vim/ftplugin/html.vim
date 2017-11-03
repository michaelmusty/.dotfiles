" Run tidy -eq -utf8 on file for the current buffer
nnoremap <LocalLeader>v :write !tidy -eq -utf8<CR>

" Make a bare URL into a link to itself
function! s:UrlLink()

  " Yank this whole whitespace-separated word
  normal! yiW
  " Open a link tag
  normal! i<a href="">
  " Paste the URL into the quotes
  normal! hP
  " Move to the end of the link text URL
  normal! E
  " Close the link tag
  normal! a</a>

endfunction
nnoremap <silent> <LocalLeader>r :<C-U>call <SID>UrlLink()<CR>
