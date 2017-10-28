" Fedora's default environment adds a few auto commands that I don't like,
" including the 'return to previous position in buffer' one; fortunately
" they're nice enough to group the commands, so I can just clear them
if has('autocmd')
  augroup fedora
    autocmd!
  augroup END
endif
