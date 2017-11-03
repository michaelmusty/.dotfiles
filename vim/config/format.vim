" If we can, add j to the format options to get rid of comment leaders when
" joining lines
if v:version > 703 || v:version ==# 703 && has('patch541')
  set formatoptions+=j
endif

"
" Use option_flags.vim plugin to bind quick toggle actions for some
" 'formatoptions' flags:
"
" a - Automatically format paragraphs, reapplying the wrap on every text
"     insertion or deletion; sometimes I want this and sometimes I
"     don't, it particularly varies when typing prose in Markdown that
"     includes headings and code
" c - Automatically wrap comments at 'textwidth' (which I allow the filetypes
"     to set for me)
" t - Automatically wrap text at 'textwidth' (as above)
"
if has('eval')
  nnoremap <silent> <leader>a
        \ :<C-U>call option_flags#toggle_local('formatoptions', 'a')<CR>
  nnoremap <silent> <leader>c
        \ :<C-U>call option_flags#toggle_local('formatoptions', 'c')<CR>
  nnoremap <silent> <leader>t
        \ :<C-U>call option_flags#toggle_local('formatoptions', 't')<CR>
endif
