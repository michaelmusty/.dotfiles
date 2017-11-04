" If we can, add j to the format options to get rid of comment leaders when
" joining lines
if v:version > 703
      \ || v:version ==# 703 && has('patch541')
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

  " 'a' is newer
  if v:version >= 700
    nnoremap <silent>
          \ <Leader>a
          \ :<C-U>ToggleOptionFlagLocal formatoptions a<CR>
  else
    nnoremap <silent>
          \ <Leader>a
          \ :<C-U>echomsg 'No "formatoptions" "a" flag in Vim < 7.0'<CR>
  endif

endif
