"
" markdown/autoformat.vim: Refine control over the 'formatoptions' flag 'a'
" for automatic formatting when editing Markdown documents:
"
" - Turn it on automatically on load if the buffer looks wrapped
" - Suspend it if editing a line in a code block (indented by four spaces)
" - Suspend it if pasting something with a linebreak
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('b:did_ftplugin_markdown_autoformat') || &compatible
  finish
endif
if !has('autocmd') || v:version < 700
  finish
endif
let b:did_ftplugin_markdown_autoformat = 1
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|unlet b:did_ftplugin_markdown_autoformat'
endif

" Turn on autoformatting if less than 5% of the buffer's lines meet all three
" of these conditions:
"
" - Longer than 'textwidth'
" - Contains at least one space (not an unsplittable line)
" - Not a code block (indented with at least four spaces)
"
if !exists('*s:Load')
  function! s:Load() abort
    let l:width = &textwidth ? &textwidth : 79
    let l:count = 0
    let l:total = line('$')
    for l:li in range(1, l:total)
      let l:line = getline(l:li)
      if strlen(l:line) > l:width
            \ && stridx(l:line, ' ') > -1
            \ && l:line !~# '\m^    '
        let l:count += 1
      endif
    endfor
    if l:count * 100 / l:total < 5
      setlocal formatoptions+=a
    else
      setlocal formatoptions-=a
    endif
  endfunction
endif
if !exists('g:markdown_autoformat_load') || g:markdown_autoformat_load
  call s:Load()
endif

" Suspend auto-formatting when in a code block (four-space indent)
if !exists('*s:Line')
  function! s:Line() abort
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
endif
if !exists('g:markdown_autoformat_line') || g:markdown_autoformat_line
  augroup ftplugin_markdown_autoformat
    autocmd!
    autocmd BufWinEnter,CursorMoved,CursorMovedI,WinEnter
          \ <buffer>
          \ call s:Line()
  augroup END
endif

" Suspend auto-format when pasting anything with a linebreak
if !exists('*s:Put')
  function! s:Put(key) abort
    let l:suspended = 0
    if &formatoptions =~# '\ma' && getreg() =~# '\m\n'
      setlocal formatoptions-=a
      let l:suspended = 1
    endif
    execute 'normal! "'.v:register.v:count1.a:key
    if l:suspended
      setlocal formatoptions+=a
    endif
  endfunction
endif
if !exists('g:markdown_autoformat_put') || g:markdown_autoformat_put
  nnoremap <buffer> <silent>
        \ p
        \ :<C-u>call <SID>Put('p')<CR>
  nnoremap <buffer> <silent>
        \ P
        \ :<C-u>call <SID>Put('P')<CR>
endif

" Undo all the above
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal formatoptions<'
        \ . '|augroup ftplugin_markdown_autoformat'
        \ . '|autocmd! * <buffer>'
        \ . '|augroup END'
endif
