" Run tidy -eq -utf8 on file for the current buffer
nnoremap <LocalLeader>v :exe "!tidy -eq -utf8 " . shellescape(expand("%"))<CR>

" Make a bare URL into a link to itself
function! s:UrlLink()
  normal! yiW
  execute "normal! i<a href=\"\<C-R>0\">\<Esc>"
  normal! E
  execute "normal! a</a>\<Esc>"
endfunction
nnoremap <silent> <LocalLeader>r :<C-U>call <SID>UrlLink()<CR>
