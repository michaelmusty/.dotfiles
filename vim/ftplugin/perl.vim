" Explicitly set indent level; this matches the global default, but it's tidy
" to enforce it in case we changed from a filetype with different value (e.g.
" VimL)
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

" Run perl -c on file for the current buffer
nnoremap <leader>pc :exe "!perl -c " . shellescape(expand("%"))<CR>
" Run perlcritic on the file for the current buffer
nnoremap <leader>pl :exe "!perlcritic " . shellescape(expand("%"))<CR>
" Run the current buffer through perltidy
nnoremap <leader>pt :%!perltidy<CR>
