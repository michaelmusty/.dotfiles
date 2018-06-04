" Only do this when not done yet for this buffer
" Also do nothing if 'compatible' enabled, or if no autocmd feature, or if Vim
" is too old to support the needed autocmd events
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
"   * Longer than 'textwidth'
"   * Contains at least one space (not an unsplittable line)
"   * Not a code block (indented with at least four spaces)
if !has('*s:Load')
  function! s:Load() abort
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
endif
call s:Load()

" Suspend auto-formatting when in a code block (four-space indent)
if !has('*s:Line')
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
augroup ftplugin_markdown_autoformat
  autocmd!
  autocmd BufWinEnter,CursorMoved,CursorMovedI,WinEnter
        \ <buffer>
        \ call s:Line()
augroup END

" Suspend auto-format when pasting anything with a linebreak
if !has('*s:Put')
  function! s:Put(above) abort
    let l:suspended = 0
    if &formatoptions =~# '\ma' && getreg() =~# '\m\n'
      setlocal formatoptions-=a
      let l:suspended = 1
    endif
    if a:above
      execute 'normal! "'.v:register.v:count1.'P'
    else
      execute 'normal! "'.v:register.v:count1.'p'
    endif
    if l:suspended
      setlocal formatoptions+=a
    endif
  endfunction
endif
nnoremap <buffer> <silent>
      \ p
      \ :<C-u>call <SID>Put(0)<CR>
nnoremap <buffer> <silent>
      \ P
      \ :<C-u>call <SID>Put(1)<CR>

" Undo all the above
if exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:undo_ftplugin
        \ . '|setlocal formatoptions<'
        \ . '|augroup ftplugin_markdown_autoformat'
        \ . '|autocmd! * <buffer>'
        \ . '|augroup END'
endif
