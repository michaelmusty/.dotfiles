" When wrapping text, if a line is so long that not all of it can be shown on
" the screen, show as much as possible anyway; by default Vim fills the left
" column with @ symbols instead, which I don't find very helpful
set display=lastline

" Don't wrap by default, but use \w to toggle it on or off quickly
set nowrap
nnoremap <leader>w :setlocal wrap!<CR>

" When wrapping, j and k should move by screen row, and not to the same
" column number in the previous logical line, which feels very clumsy and is
" seldom particularly helpful; you can use n| to jump to the nth column in a
" line anyway if you need to
nnoremap j gj
nnoremap k gk

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
      if &l:linebreak
        setlocal nolinebreak
        setlocal showbreak=
        if v:version > 704 || v:version ==# 704 && has('patch338')
          setlocal nobreakindent
        endif
      else
        setlocal linebreak
        setlocal showbreak=...
        if v:version > 704 || v:version ==# 704 && has('patch338')
          setlocal breakindent
        endif
      endif
    endfunction
    nnoremap <silent> <leader>b :<C-U>call <SID>ToggleBreak()<CR>
  endif
endif
