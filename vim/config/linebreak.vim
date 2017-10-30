" Break lines at word boundaries if possible and not simply at the last
" character that will fit on the screen, preceding the next line with three
" periods to make it obvious that it's a continuation of the previous line
if has('linebreak')
  set linebreak
  set showbreak=...
  if v:version > 704 || v:version ==# 704 && has('patch338')
    set breakindent
  endif

  " Bind \b to turn off linebreak and toggle the showbreak characters on and
  " off for convenience of copypasting multiple lines from terminal emulators.
  if has('eval')
    function! s:ToggleBreak()
      if &linebreak
        set nolinebreak
        set showbreak=
        if v:version > 704 || v:version ==# 704 && has('patch338')
          set nobreakindent
        endif
      else
        set linebreak
        set showbreak=...
        if v:version > 704 || v:version ==# 704 && has('patch338')
          set breakindent
        endif
      endif
    endfunction
    nnoremap <silent> <leader>b :<C-U>call <SID>ToggleBreak()<CR>
  endif
endif
