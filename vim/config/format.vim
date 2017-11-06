" Try to set the 'j' flag for 'formatoptions', to automatically delete comment
" leaders when joining lines
silent! set formatoptions+=j

" Use toggle_option_flag.vim plugin to bind quick toggle actions for some
" 'formatoptions' flags
if has('user_commands')

  " a: Reformat paragraphs to 'textwidth' on all insert or delete operations
  nnoremap <silent>
        \ <Leader>a
        \ :<C-U>ToggleOptionFlagLocal formatoptions a<CR>

  " c: Reformat comments to 'textwidth'
  nnoremap <silent>
        \ <Leader>c
        \ :<C-U>ToggleOptionFlagLocal formatoptions c<CR>

  " j: Delete comment leaders when joining lines
  nnoremap <silent>
        \ <Leader>j
        \ :<C-U>ToggleOptionFlagLocal formatoptions j<CR>

  " t: Reformat non-comment text to 'textwidth'
  nnoremap <silent>
        \ <Leader>t
        \ :<C-U>ToggleOptionFlagLocal formatoptions t<CR>
endif
