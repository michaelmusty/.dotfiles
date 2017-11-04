" Some special settings for searching, if available
if has('extra_search')

  " Searching as I enter my pattern, \i toggles this
  set incsearch
  nnoremap <silent>
        \ <Leader>i
        \ :<C-U>setlocal incsearch! incsearch?<CR>

  " Highlight search results, \h toggles this
  set hlsearch
  nnoremap <silent>
        \ <Leader>h
        \ :<C-U>setlocal hlsearch! hlsearch?<CR>

  " Pressing ^L will clear highlighting until the next search-related
  " operation; quite good because the highlighting gets distracting after
  " you've found what you wanted
  nnoremap <silent>
        \ <C-L>
        \ :<C-U>nohlsearch<CR><C-L>

  " Clear search highlighting as soon as I enter insert mode, and restore it
  " once I leave it
  if has('autocmd')
    augroup dotfiles_highlight
      autocmd!
      autocmd InsertEnter
            \ *
            \ setlocal nohlsearch
      autocmd InsertLeave
            \ *
            \ setlocal hlsearch
    augroup END
  endif
endif
