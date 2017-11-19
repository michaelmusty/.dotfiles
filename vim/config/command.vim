" Keep plenty of command and search history, because disk space is cheap
set history=2000

" Always tell me the number of lines changed by a command
set report=0

" Command-line based features
if has('cmdline_info')

  " Show my current position in the status bar
  set ruler

  " Show the keystrokes being entered in the screen
  set showcmd

  " Show the mode we're using if not normal mode (e.g. --INSERT--)
  set showmode

endif

" \d inserts the current local date from date(1)
nnoremap <silent>
      \ <Leader>d
      \ :<C-U>read !date<CR>
" \D inserts the current UTC date from date(1)
nnoremap <silent>
      \ <Leader>D
      \ :<C-U>read !date -u<CR>

" \m in visual/select mode starts a mail message with the selected lines
vmap <Leader>m <Plug>MailMuttSelected
" \m in normal mode starts a mail message with the current line
nmap <Leader>m <Plug>MailMuttLine
" \M in normal mode starts a mail message with the whole buffer
nmap <Leader>M <Plug>MailMuttBuffer
