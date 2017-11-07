"
" strip_trailing_whitespace.vim: User-defined key mapping and optional command
" to strip trailing whitespace in the whole document.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_strip_trailing_whitespace')
      \ || &compatible
  finish
endif
let g:loaded_strip_trailing_whitespace = 1

" Define function for stripping whitespace
function! s:StripTrailingWhitespace()

  " Iterating line number
  let l:li = 1

  " Line number of last line that had non-whitespace characters on it
  let l:lw = 0

  " Line number of the file's last line
  let l:ll = line('$')

  " Iterate over the lines
  while l:li <= l:ll

    " Get the line text
    let l:line = getline(l:li)

    " Replace the line with a subsitution of its text stripping extraneous
    " whitespace
    call setline(l:li, substitute(l:line, '\m\C\s\+$', '', 'g'))

    " If this line has any non-whitespace characters on it, update l:lw with
    " its index
    if l:line =~# '\m\S'
      let l:lw = l:li
    endif

    " Increment the line counter for the next iteration
    let l:li = l:li + 1

  endwhile

  " If the last non-whitespace line was before the last line proper, we can
  " delete all lines after it
  if l:lw < l:ll

    " Get the current line and column so we can return to it
    " (Yes I know about winsaveview() and winrestview(); I want this to work
    " even on very old versions of Vim if possible)
    let l:lc = line('.')
    let l:cc = col('.')

    " Delete the lines, which will move the cursor
    silent execute l:lw + 1 . ',$ delete'

    " Return the cursor to the saved position
    call cursor(l:lc, l:cc)
  endif

endfunction

" Create mapping proxy to the function just defined
noremap <silent> <unique>
      \ <Plug>StripTrailingWhitespace
      \ :<C-U>call <SID>StripTrailingWhitespace()<CR>

" Define a user command too, if we can
if has('user_commands')
  command -nargs=0
        \ StripTrailingWhiteSpace
        \ call <SID>StripTrailingWhitespace()
endif
