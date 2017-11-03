" Configure spell checking features, if available
if has('spell')

  " Don't check spelling by default, but bind \s to toggle this
  set nospell
  nnoremap <Leader>s :setlocal spell! spell?<CR>

  " Use New Zealand English for spelling by default (it's almost identical
  " to British English), but bind \u to switch to US English and \z to
  " switch back
  set spelllang=en_nz
  nnoremap <Leader>u :setlocal spelllang=en_us spelllang?<CR>
  nnoremap <Leader>z :setlocal spelllang=en_nz spelllang?<CR>
endif
