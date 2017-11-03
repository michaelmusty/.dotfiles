"
" Bind a user-defined key sequence to turn off linebreak and toggle the
" showbreak characters and breakindent mode on and off, for convenience of
" copying multiple lines from terminal emulators.
"
" Suggested mapping: <leader>b
"
if has('eval')

  " Define function
  function! s:CopyLinebreak()

    " If linebreak is on, turn it off
    if &l:linebreak
      setlocal nolinebreak linebreak?
      setlocal showbreak=
      if exists('&breakindent')
        setlocal nobreakindent
      endif

    " If it's off, turn it on
    else
      setlocal linebreak linebreak?
      setlocal showbreak<
      if exists('&breakindent')
        setlocal breakindent
      endif
    endif

  endfunction

  " Provide mapping proxy to the function just defined
  " Suggested mapping: <leader>b
  noremap <Plug>CopyLinebreak
        \ :<C-U>call <SID>CopyLinebreak()<CR>
endif
