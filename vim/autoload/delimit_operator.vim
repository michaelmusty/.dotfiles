let s:pairs = {
      \ '(': ')',
      \ '<': '>',
      \ '[': ']',
      \ '{': '}',
      \ }

function! delimit_operator#Operatorfunc(type) abort

  let l:save = {
        \ 'unnamed': @@,
        \ 'clipboard': &clipboard,
        \ 'selection': &selection
        \ }

  set clipboard-=unnamed
  set clipboard-=unnamedplus

  set selection=inclusive

  let l:delimiters = {
        \ 'open': s:char,
        \ 'close': get(s:pairs, s:char, s:char)
        \ }

  if a:type ==# 'line'
    silent normal! '[V']y
  elseif a:type ==# 'block'
    silent execute "normal! `[\<C-V>`]y"
  else
    silent normal! `[v`]y
  endif

  let @@ = l:delimiters['open']
        \ . @@
        \ . l:delimiters['close']

  silent normal! gvp

  let @@ = l:save['unnamed']
  let &clipboard = l:save['clipboard']
  let &selection = l:save['selection']

endfunction

function! delimit_operator#Map() abort
  let s:char = nr2char(getchar())
  set operatorfunc=delimit_operator#Operatorfunc
  return 'g@'
endfunction
