let s:paths = [
      \ $HOME.'/.fortunes',
      \ $HOME.'/.local/share/games/fortunes',
      \]
highlight Fortune
      \ term=NONE
      \ cterm=NONE ctermfg=248 ctermbg=NONE

function! fortune#() abort
  if !has('unix')
    echoerr 'Only works on *nix'
  endif
  if !executable('fortune')
    echoerr 'Missing "fortune" executable'
  endif
  if !executable('timeout')
    echoerr 'Missing "timeout" executable'
  endif
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
        \ '[[:cntrl:]]\+',
        \ ' ',
        \ 'g',
        \)
  echohl Fortune
  echo fortune
  echohl None
endfunction
