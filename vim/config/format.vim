" All of this variable logic requires 'eval', and I can't just short-circuit
" it due to a quirk in the way vim-tiny evaluates these expressions
if has('eval')

  " Figure out if we have the 'j' flag for 'formatoptions', to automatically
  " delete comment leaders when joining lines; keep it in a script variable
  let s:formatoptions_has_j = v:version > 703
        \ || v:version == 703 && has('patch541')

  " If we do have 'j', default to setting it
  if s:formatoptions_has_j
    set formatoptions+=j
  endif

  "
  " Use toggle_option_flag.vim plugin to bind quick toggle actions for some
  " 'formatoptions' flags; both of the above, plus:
  "
  " c - Automatically wrap comments at 'textwidth' (which I allow the filetypes
  "     to set for me)
  " t - Automatically wrap text at 'textwidth' (as above)
  "
  " We need user-defined commands to do this.
  "
  if !has('user_commands')
    finish
  endif

  " 'c' and 't' have both been around since at least 6.1
  nnoremap <silent>
        \ <Leader>c
        \ :<C-U>ToggleOptionFlagLocal formatoptions c<CR>
  nnoremap <silent>
        \ <Leader>t
        \ :<C-U>ToggleOptionFlagLocal formatoptions t<CR>

  " Figure out if we have the 'a' flag for 'formatoptions', to reapply
  " 'textwidth' wrapping to the current paragraph on every insertion or
  " deletion; keep in a script variable
  let s:formatoptions_has_a = v:version > 610
        \ || v:version == 610 && has('patch142')

  " 'a' needs testing
  if s:formatoptions_has_a
    nnoremap <silent>
          \ <Leader>a
          \ :<C-U>ToggleOptionFlagLocal formatoptions a<CR>
  else
    nnoremap <silent>
          \ <Leader>a
          \ :<C-U>echoerr 'No formatoptions a-flag'<CR>
  endif

  " 'j' needs testing
  if s:formatoptions_has_j
    nnoremap <silent>
          \ <Leader>j
          \ :<C-U>ToggleOptionFlagLocal formatoptions j<CR>
  else
    nnoremap <silent>
          \ <Leader>j
          \ :<C-U>echoerr 'No formatoptions j-flag'<CR>
  endif

endif
