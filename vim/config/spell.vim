" Configure spell checking features, if available
if has('spell')

  " Don't check spelling by default, but bind \s to toggle this
  set nospell
  nnoremap <leader>s :setlocal spell! spell?<CR>

  " Use New Zealand English for spelling by default (it's almost identical
  " to British English), but bind \u to switch to US English and \z to
  " switch back
  set spelllang=en_nz
  nnoremap <leader>u :setlocal spelllang=en_us spelllang?<CR>
  nnoremap <leader>z :setlocal spelllang=en_nz spelllang?<CR>
endif
