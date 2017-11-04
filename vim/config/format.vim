" Figure out if we have the 'a' flag for 'formatoptions', to reapply
" 'textwidth' wrapping to the current paragraph on every insertion or
" deletion; keep in a script variable
let s:formatoptions_has_a = v:version > 700

" Figure out if we have the 'j' flag for 'formatoptions', to automatically
" delete comment leaders when joining lines; keep it in a script variable
let s:formatoptions_has_j = v:version > 703
      \ || v:version ==# 703 && has('patch541')

" If we do have 'j', default to setting it
if s:formatoptions_has_j
  set formatoptions+=j
endif

"
" Use toggle_option_flag.vim plugin to bind quick toggle actions for some
" 'formatoptions' flags:
"
" c - Automatically wrap comments at 'textwidth' (which I allow the filetypes
"     to set for me)
" t - Automatically wrap text at 'textwidth' (as above)
"
" Only in Vim >= 7.0 (I think):
"
" a - Automatically format paragraphs, reapplying the wrap on every text
"     insertion or deletion; sometimes I want this and sometimes I
"     don't, it particularly varies when typing prose in Markdown that
"     includes headings and code
"
if has('eval') && has('user_commands')

  " 'c' and 't' have both been around since at least 6.1
  nnoremap <silent>
        \ <Leader>c
        \ :<C-U>ToggleOptionFlagLocal formatoptions c<CR>
  nnoremap <silent>
        \ <Leader>t
        \ :<C-U>ToggleOptionFlagLocal formatoptions t<CR>

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

endif
