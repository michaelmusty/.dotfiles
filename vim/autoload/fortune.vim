let s:paths = [
      \ $HOME.'/.fortunes',
      \ $HOME.'/.local/share/games/fortunes',
      \]

let s:executables = [
      \ 'fortune',
      \ 'timeout',
      \]

function! s:Highlight() abort
  highlight Fortune
        \ term=NONE
        \ cterm=NONE ctermfg=248 ctermbg=NONE
        \ gui=NONE guifg=#585858 guibg=NONE
endfunction
augroup fortune
  autocmd!
  autocmd ColorScheme *
        \ call s:Highlight()
augroup END
doautocmd fortune ColorScheme

function! fortune#() abort

  for executable in s:executables
    if !executable(executable)
      echoerr 'Missing executable "'.executable.'"'
    endif
  endfor

  let limit = &columns - 1

  let command = [
        \ 'timeout',
        \ '0.3s',
        \ 'fortune',
        \ '-s',
        \ '-n',
        \ limit,
        \]

  for path in s:paths
    if isdirectory(path)
      call add(command, path)
      break
    endif
  endfor

  let fortune = substitute(
        \ system(join(command)),
        \ '[[:cntrl:][:space:]]\+',
        \ ' ',
        \ 'g',
        \)

  echohl Fortune
  echo fortune
  echohl None

endfunction
