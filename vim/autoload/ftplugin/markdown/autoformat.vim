" Autoload functions for after/ftplugin/markdown/autoformat.vim

" Suspend auto-format when pasting anything with a linebreak
function! ftplugin#markdown#autoformat#Line() abort
  if getline('.') =~# '\m^    '
    if &formatoptions =~# '\ma'
      setlocal formatoptions-=a
      let b:markdown_autoformat_suspended = 1
    endif
  elseif exists('b:markdown_autoformat_suspended')
    setlocal formatoptions+=a
    unlet b:markdown_autoformat_suspended
  endif
endfunction

" Suspend auto-formatting when in a code block (four-space indent)
function! ftplugin#markdown#autoformat#Put(above) abort
  let l:suspended = 0
  if &formatoptions =~# '\ma' && @" =~# '\m\n'
    setlocal formatoptions-=a
    let l:suspended = 1
  endif
  if a:above
    normal! P
  else
    normal! p
  endif
  if l:suspended
    setlocal formatoptions+=a
  endif
endfunction

" Wrapper functions for #Put() above/below
function! ftplugin#markdown#autoformat#PutAbove() abort
  call ftplugin#markdown#autoformat#Put(1)
endfunction
function! ftplugin#markdown#autoformat#PutBelow() abort
  call ftplugin#markdown#autoformat#Put(0)
endfunction
