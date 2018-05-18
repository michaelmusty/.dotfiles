" Don't wrap by default, but use \w to toggle it on or off quickly
set nowrap
nnoremap <silent>
      \ <Leader>w
      \ :<C-U>set wrap! wrap?<CR>

" When wrapping text, if a line is so long that not all of it can be shown on
" the screen, show as much as possible anyway; by default Vim fills the left
" column with @ symbols instead, which I don't find very helpful
set display=lastline

" Clearly show when the start or end of the row does not correspond to the
" start and end of the line
set listchars+=precedes:<,extends:>

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

  " If we have the option, indent wrapped lines as much as the first line
  if exists('+breakindent')
    set breakindent
  endif

  " \b toggles copy-pasteable linebreak settings
  nmap <Leader>b <Plug>CopyLinebreakToggle

endif
