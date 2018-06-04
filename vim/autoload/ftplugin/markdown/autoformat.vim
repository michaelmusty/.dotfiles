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

" Turn on autoformatting if less than 5% of the buffer's lines meet all three
" of these conditions:
"   * Longer than 'textwidth'
"   * Contains at least one space (not an unsplittable line)
"   * Not a code block (indented with at least four spaces)
function! ftplugin#markdown#autoformat#Load() abort
  let l:width = &textwidth ? &textwidth : 79
  let l:count = 0
  let l:total = line('$')
  for l:li in range(1, l:total)
    let l:line = getline(l:li)
    if strlen(l:line) > l:width
          \ && stridx(l:line, ' ') > -1
          \ && l:line !~# '\m^    '
      let l:count = l:count + 1
    endif
  endfor
  if l:count * 100 / l:total < 5
    setlocal formatoptions+=a
  else
    setlocal formatoptions-=a
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
