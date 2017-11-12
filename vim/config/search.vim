" Some special settings for searching, if available
if has('extra_search')

  " Searching as I enter my pattern, \i toggles this
  set incsearch
  nnoremap <silent>
        \ <Leader>i
        \ :<C-U>set incsearch! incsearch?<CR>

  " Highlight search results, \h toggles this
  set hlsearch
  nnoremap <silent>
        \ <Leader>h
        \ :<C-U>set hlsearch! hlsearch?<CR>

  " Pressing ^L will clear highlighting until the next search-related
  " operation; quite good because the highlighting gets distracting after
  " you've found what you wanted
  nnoremap <silent>
        \ <C-L>
        \ :<C-U>nohlsearch<CR><C-L>

endif
