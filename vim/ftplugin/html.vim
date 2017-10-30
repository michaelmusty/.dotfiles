" Explicitly set indent level; this matches the global default, but it's tidy
" to enforce it in case we changed from a filetype with different value (e.g.
" VimL)
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

" Run tidy -eq -utf8 on file for the current buffer
nnoremap <leader>v :exe "!tidy -eq -utf8 " . shellescape(expand("%"))<CR>

" Make a bare URL into a link to itself
function! UrlLink()
  normal yiW
  execute "normal i<a href=\"\<C-R>0\">\<Esc>"
  normal E
  execute "normal a</a>\<Esc>"
endfunction
nnoremap <silent> <leader>r :<C-U>call UrlLink()<CR>
