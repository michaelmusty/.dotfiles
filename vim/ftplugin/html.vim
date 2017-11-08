" Run `tidy -errors -quiet` over buffer
nnoremap <buffer> <silent>
      \ <LocalLeader>c
      \ :<C-U>write !tidy -errors -quiet<CR>

" Filter buffer through `tidy`
nnoremap <buffer> <silent>
      \ <LocalLeader>t
      \ :<C-U>%!tidy -quiet<CR>

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

" Mapping for the function above
nnoremap <buffer> <silent>
      \ <LocalLeader>r
      \ :<C-U>call <SID>UrlLink()<CR>

" Unload this filetype plugin
let b:undo_user_ftplugin
      \ = 'silent! nunmap <LocalLeader>c'
      \ . '|silent! nunmap <LocalLeader>t'
      \ . '|silent! nunmap <LocalLeader>r'
