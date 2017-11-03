" Some special settings for searching, if available
if has('extra_search')

  " Searching as I enter my pattern, \i toggles this
  set incsearch
  nnoremap <leader>i :setlocal incsearch! incsearch?<CR>

  " Highlight search results, \h toggles this
  set hlsearch
  nnoremap <leader>h :setlocal hlsearch! hlsearch?<CR>

  " Pressing ^L will clear highlighting until the next search-related
  " operation; quite good because the highlighting gets distracting after
  " you've found what you wanted
  nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

  " Clear search highlighting as soon as I enter insert mode, and restore it
  " once I leave it
  if has('autocmd')
    augroup dotfiles_highlight
      autocmd!
      silent! autocmd InsertEnter * setlocal nohlsearch
      silent! autocmd InsertLeave * setlocal hlsearch
    augroup END
  endif
endif
