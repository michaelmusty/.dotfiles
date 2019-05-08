" Move between diff block headers
function! diff#MoveBlock(count, up, visual) abort

  " Reselect visual selection
  if a:visual
    normal! gv
  endif

  " Flag for the number of blocks passed
  let blocks = 0

  " Iterate through buffer lines
  let num = line('.')
  while a:up ? num > 1 : num < line('$')
    let num += a:up ? -1 : 1
    if getline(num) =~# '^@@'
      let blocks += 1
      if blocks == a:count
        break
      endif
    endif
  endwhile

  " Move to line if nonzero and not equal to the current line
  if num != line('.')
    execute 'normal '.num.'G'
  endif

endfunction
