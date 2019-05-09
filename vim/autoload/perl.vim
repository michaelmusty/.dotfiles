" Function to add boilerplate intelligently
function! perl#Boilerplate() abort

  " Flag whether the buffer started blank
  let blank = line2byte(line('$') + 1) <= 2

  " This is a .pm file, guess its package name from path
  if expand('%:e') ==# 'pm'

    let match = matchlist(expand('%:p'), '.*/lib/\(.\+\).pm$')
    if len(match)
      let package = substitute(match[1], '/', '::', 'g')
    else
      let package = expand('%:t:r')
    endif

  " Otherwise, just use 'main'
  else
    let package = 'main'
  endif

  " Lines always to add
  let lines = [
        \ 'package '.package.';',
        \ '',
        \ 'use strict;',
        \ 'use warnings;',
        \ 'use utf8;',
        \ '',
        \ 'use 5.006;',
        \ '',
        \ 'our $VERSION = ''0.01'';',
        \ ''
        \ ]

  " Conditional lines depending on package
  if package ==# 'main'
    let lines = ['#!perl'] + lines
  else
    let lines = lines + ['', '1;']
  endif

  " Add all the lines in the array
  for line in lines
    call append(line('.') - 1, line)
  endfor

  " If we started in a completely empty buffer, delete the current blank line
  if blank
    delete
  endif

  " If we added a trailing '1' for a package, move the cursor up two lines
  if package !=# 'main'
    -2
  endif

endfunction
