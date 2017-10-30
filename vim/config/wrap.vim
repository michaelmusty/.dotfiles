" Don't wrap by default, but use \w to toggle it on or off quickly
set nowrap
nnoremap <leader>w :setlocal wrap! wrap?<CR>

" When wrapping text, if a line is so long that not all of it can be shown on
" the screen, show as much as possible anyway; by default Vim fills the left
" column with @ symbols instead, which I don't find very helpful
set display=lastline

" When wrapping, j and k should move by screen row, and not to the same
" column number in the previous logical line, which feels very clumsy and is
" seldom particularly helpful; you can use n| to jump to the nth column in a
" line anyway if you need to
nnoremap j gj
nnoremap k gk

" Line break settings and mappings
if has('linebreak')

  " Break lines at word boundaries if possible
  set linebreak

  " Precede continued lines with '...'
  set showbreak=...

  " If we have the option, indent wrapped lines as much as the first line;
  " keep
  let s:breakindent = v:version > 704
        \ || v:version ==# 704 && has('patch338')
  if s:breakindent
    set breakindent
  endif

  " Bind \b to turn off linebreak and toggle the showbreak characters on and
  " off for convenience of copypasting multiple lines from terminal emulators.
  if has('eval')

    " Define function
    function! s:ToggleBreak()

      " If linebreak is on, turn it off
      if &l:linebreak
        setlocal nolinebreak linebreak?
        setlocal showbreak=
        if s:breakindent
          setlocal nobreakindent
        endif

      " If it's off, turn it on
      else
        setlocal linebreak linebreak?
        setlocal showbreak=...
        if s:breakindent
          setlocal breakindent
        endif
      endif

    endfunction

    " Map \b to defined function
    nnoremap <silent> <leader>b :<C-U>call <SID>ToggleBreak()<CR>

  endif
endif
