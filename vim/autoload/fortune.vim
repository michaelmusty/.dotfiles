" Declare paths to check for fortune files
let s:paths = [
      \ $HOME.'/.fortunes',
      \ $HOME.'/.local/share/games/fortunes',
      \]

" List of executables for which we need to check
let s:executables = [
      \ 'fortune',
      \ 'timeout',
      \]

" Entry point for plugin
function! fortune#() abort

  " Check we have all of the executables we need
  for executable in s:executables
    if !executable(executable)
      echoerr 'Missing executable "'.executable.'"'
    endif
  endfor

  " Maximum length of fortunes is the width of the screen minus 1; characters
  " wider than one column will break this
  "
  let limit = &columns - 1

  " Some implementations of fortune(6) thrash the disk if they can't meet the
  " length limit, so we need to rap this invocation in a timeout(1) call
  let command = [
        \ 'timeout',
        \ '0.3s',
        \ 'fortune',
        \ '-s',
        \ '-n',
        \ limit,
        \]

  " Find a path for custom fortunes and add it on to the command if found
  for path in s:paths
    if isdirectory(path)
      call add(command, path)
      break
    endif
  endfor

  " Run the command and condense any control or space character groups into
  " just one space
  let fortune = substitute(
        \ system(join(command)),
        \ '[[:cntrl:][:space:]]\+',
        \ ' ',
        \ 'g',
        \)

  " Show the fortune message!
  echomsg fortune

endfunction
